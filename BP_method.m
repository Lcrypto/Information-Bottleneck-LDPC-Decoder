classdef BP_method <handle 
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        H;
        VariTable;
        vari_degree;
        CheckTable;
        check_degree;
        IterNum; 
        CWLength;
        p_flag;
        p_bits;
    end
    
    methods
        function obj = BP_method(H,VariTable,vari_degree,CheckTable,check_degree,IterNum,CWLength,p_flag,p_bits)
            obj.H=H;
            obj.VariTable=VariTable;
            obj.vari_degree=vari_degree;
            obj.CheckTable=CheckTable;
            obj.check_degree=check_degree;
            obj.IterNum=IterNum;
            obj.CWLength=CWLength;
            obj.p_flag=p_flag;
            obj.p_bits=p_bits;           
        end
        
        function [FinalBits]=LDPC_Decoder(obj,Posterior,trans_bits)
            [CNum,~]=size(obj.CheckTable);
            [VNum,~]=size(obj.VariTable);
            %H_lc=obj.H;
            MsgC2V=zeros(CNum,VNum);        %Initialize the message from CN to VN;
            
            
            %LLRTotal=zeros(1,VNum);           %Initialize the LLR matrix;
            PostLLR=Posterior;              %convert posteriors to log form
            %% Initialize MsgV2C
            MsgV2C=repmat(PostLLR,CNum,1);
            MsgV2C=MsgV2C.*obj.H;
            %% Start Iteration
            for hh=1:obj.IterNum
                %% CN->VN Message Passing
                for ii =1:CNum                  %%Note: ii is the index of check node
                    Dc=obj.check_degree(ii);
                    VnodesC=obj.CheckTable(ii,1:Dc);       %%Obtain the varaible node connected by ii
                    for jj=1:Dc
                        VarNode=VnodesC(jj);        %%Variable Node connected by C
                        Neighbors=VnodesC;
                        Neighbors(jj)=[];           %% delete itself
                        %MsgC2V(ii,VarNode)=C2VPassing(Neighbors,MsgV2C,ii);
                        MsgC2V(ii,VarNode)=2*atanh(prod(tanh(0.5*MsgV2C(ii,Neighbors))));   
                    end
                end
                %% VN->CN Message Passing
                %% v->c
                for ii =1:VNum
                    Dv=obj.vari_degree(ii);
                    CNodesV=obj.VariTable(ii,1:Dv);
                    for jj=1:Dv
                        CheNode=CNodesV(jj);
                        Neighbors=CNodesV;
                        Neighbors(jj)=[];
                        %MsgV2C(CheNode,ii)=V2CPassing(Neighbors,MsgC2V,ii,PostLLR(ii));
                        MsgV2C(CheNode,ii)=sum(MsgC2V(Neighbors,ii))+PostLLR(ii);
                        if MsgV2C(CheNode,ii) == 0
                            a=1;
                        end 
                    end
                end
                LLRTotal=PostLLR+sum(MsgC2V);
                histogram(LLRTotal);
                xlim([-30 30]);
                %% Bit Dicision
                FinalBits=zeros(1,VNum);
                for ii=1:VNum
                    LLR=LLRTotal(ii);
                    if LLR<0
                        FinalBits(ii)=1;
                    elseif LLR>0
                        FinalBits(ii)=0;
                    else
                        FinalBits(ii)= binornd(1,0.5);
                    end
                end
                %% Stop or not
                if sum(FinalBits~=trans_bits)==0
                    break;
                end                
            end

            
        end
        
        function [ber,fer]= continuous_BP(obj,Eb_N0,Runtime,CodeRate)
            cwLength=obj.CWLength;
            bit_error=zeros(1,Runtime);
            frame_error=zeros(1,Runtime);
            P_bits=obj.p_bits;
            P_flag=obj.p_flag;
            for mm=1:Runtime
                trans_bits=zeros(1,cwLength);
                CodeWord=-2*trans_bits+1;                                           % Convert Binary Bits to Codeword
                sigma2=10^(-0.1*Eb_N0)/(2*CodeRate);
                TransCD=CodeWord+normrnd(0,sqrt(sigma2),1,cwLength);                % add noise
                LLR_in=TransCD*(2/sigma2);
                if P_flag==1
                    LLR_in(1:P_bits)=0;
                end                
                [FinalBits] = LDPC_Decoder(obj,LLR_in,trans_bits);
                bit_error(mm)=sum(trans_bits~=FinalBits);
                if bit_error(mm) ~= 0
                    frame_error(mm)=1;
                end
                display(['LLR - Method under:' num2str(Eb_N0) 'has run'  num2str(mm/Runtime)]);
            end
            ber=sum(bit_error)/(Runtime*obj.CWLength);
            fer=sum(frame_error)/Runtime;
        end
        
        function [ber,fer]= finite_min_sum(obj,Eb_N0,Runtime,CodeRate,integer_bits,fraction_bits,offset_factor)

            
            cwLength=obj.CWLength;
            bit_error=zeros(1,Runtime);
            frame_error=zeros(1,Runtime);
            P_bits=obj.p_bits;
            P_flag=obj.p_flag;
            for mm=1:Runtime
                trans_bits=zeros(1,cwLength);
                CodeWord=-2*trans_bits+1;                                           % Convert Binary Bits to Codeword
                sigma2=10^(-0.1*Eb_N0)/(2*CodeRate);
                TransCD=CodeWord+normrnd(0,sqrt(sigma2),1,cwLength);                % add noise
                LLR_in=TransCD*(2/sigma2);
                if P_flag==1
                    LLR_in(1:P_bits)=0;
                end
                [FinalBits] = LDPC_Decoder(obj,LLR_in,trans_bits);
                bit_error(mm)=sum(trans_bits~=FinalBits);
                if bit_error(mm) ~= 0
                    frame_error(mm)=1;
                end
                display(['LLR - Method under:' num2str(Eb_N0) 'has run'  num2str(mm/Runtime)]);
            end
            ber=sum(bit_error)/(Runtime*obj.CWLength);
            fer=sum(frame_error)/Runtime;
        end
                
        function [ber,fer] = quatize_BP(obj,Eb_N0,Runtime,CodeRate,Max,Min,Obsize,ProbConTY,LLR_table)
            cwLength=obj.CWLength;
            bit_error=zeros(1,Runtime);
            frame_error=zeros(1,Runtime);
            for mm=1:Runtime
                trans_bits=zeros(1,cwLength);
                CodeWord=-2*trans_bits+1;                                           % Convert Binary Bits to Codeword
                sigma2=10^(-0.1*Eb_N0)/(2*CodeRate);
                TransCD=CodeWord+normrnd(0,sqrt(sigma2),1,cwLength);                % add noise

                [ DisCW ] = Discrete( TransCD,Max,Min,Obsize );
                [QuanChan]=Channel_Mapping( DisCW,ProbConTY );                      % Discrete Input with cardi T
                LLR_in=zeros(1,cwLength);
                for ii=1:cwLength
                    a=QuanChan(ii);
                    for kk=1:length(LLR_table)
                        if a==kk
                            LLR_in(ii)=LLR_table(a);
                        end
                    end
                end
                if obj.p_flag ==1
                    LLR_in(1:obj.p_bits)=0;
                end
                [FinalBits] = LDPC_Decoder(obj,LLR_in,trans_bits);
                bit_error(mm)=sum(FinalBits);
                if bit_error(mm) ~= 0
                    frame_error(mm)=1;
                end
            end
            ber=sum(bit_error)/(Runtime*obj.CWLength);
            fer=sum(frame_error)/Runtime;
        end
        
        %% qunatization part
        function [quan_val]= Quantize (Val, integer_bits, fractionbits)    
            quan_val=zeors(1,length(Val));
            quan_max=2^(integer_bits-1)-1;
            quan_min=2^(integer_bits-1);
            for ii=1:length(Val)
                Sgn=sign(Val(ii));
                abs_val=abs(Val(ii));
                inte_part=fix(abs_val);
                frac_part=abs_val-inte_part;
                frac_bi=f_d2b(frac_part);
                if Sgn==1   %% positive num
                    quan_val(ii)=max(abs_val,quan_max)+f_d2b(frac_bi(1:fractionbits+2));
                else        %% negtive num
                    quan_val(ii)=-(max(abs_val,quan_min)+f_d2b(frac_bi(1:fractionbits+2)));
                end
            end
        end
        
        
        
    end   
end

