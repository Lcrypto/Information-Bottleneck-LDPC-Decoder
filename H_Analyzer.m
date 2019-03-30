classdef H_Analyzer<handle
    %UNTITLED6 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        H;
        G;
        n;
        k;
        CodeRate;
        p_flag;
        p_bits;
        vari_table;
        check_table;
        check_degree;
        vari_degree;
        dc_max;
        dv_max;
        vari_edge_dis;
        check_edge_dis;
        dv_degree_dis;
        dc_degree_dis;
        
        
    end
    
    methods
        function obj= H_Analyzer (H,p_flag,p_bits)
            obj.H=H;
            [obj.k,obj.n]=size(obj.H);
            obj.p_flag=p_flag;
            obj.p_bits=p_bits;
            if p_flag ==1
                obj.CodeRate=(obj.n-obj.k)/(obj.n-obj.p_bits);
            else
                obj.CodeRate=(obj.n-obj.k)/obj.n;
            end
            obj.check_degree=zeros(1,obj.k);
            obj.vari_degree=zeros(1,obj.n);
        end 
        
        function [flag]= G_constructor(obj)
            H_gf2=gf(obj.H,2);      %%The whole process is in GF2
            [num_chec,num_vari]=size(H_gf2);
            num_msg=num_vari-num_chec;
            H_left_square_part=H_gf2(:,1:num_chec);
            H_right_non_square=H_gf2(:,num_chec+1:num_vari);
            H_right_square_part=H_gf2(:,num_vari-num_chec+1:num_vari);
            H_left_non_square=H_gf2(:,1:num_vari-num_chec);
            if rank(H_left_square_part)==num_chec
                flag=1;
                G_loc=[((H_left_square_part)\H_right_non_square).' eye(num_msg)];
            elseif rank(H_right_square_part)==num_chec
                flag=1;
                G_loc=[eye(num_msg) (H_right_square_part\H_left_non_square).'];
            else
                flag=0;
                G_loc=0;
            end
            obj.G=G_loc;  
            DISP('Generator Matrix successfully Analyzed!');
        end 
        
        function degree_table_constuctor(obj)
            for ii=1:obj.k
                obj.check_degree(ii)=nnz(obj.H(ii,:));
            end
            for ii=1:obj.n
                obj.vari_degree(ii)=nnz(obj.H(:,ii));
            end
            obj.dc_max=max(obj.check_degree);
            obj.dv_max=max(obj.vari_degree);
            disp('Degree Table is Constructed !');
        end
        
        function vari_check_table_constructor (obj)
            obj.check_table=zeros(obj.k,obj.dc_max);
            obj.vari_table=zeros(obj.n,obj.dv_max);
            for ii=1:obj.k
                M=find(obj.H(ii,:)~=0);
                obj.check_table(ii,1:length(M))=M;
            end            
            for ii=1:obj.n
                M=find(obj.H(:,ii)~=0).';
                obj.vari_table(ii,1:length(M))=M;
            end
            disp('Vari and Check Table is Constructed !');
        end
        
        function edge_distribution(obj)
            degree_v=1:obj.dv_max;
            obj.dv_degree_dis=zeros(1,obj.dv_max);
            for ii=1:obj.n
                cur_degree=obj.vari_degree(ii);
                obj.dv_degree_dis(cur_degree)=obj.dv_degree_dis(cur_degree)+1;
            end            
            degree_c=1:obj.dc_max;
            obj.dc_degree_dis=zeros(1,obj.dc_max);
            for ii=1:obj.k
                cur_degree=obj.check_degree(ii);
                if (cur_degree==0)
                    a=1;
                end
                obj.dc_degree_dis(cur_degree)=obj.dc_degree_dis(cur_degree)+1;
            end
            
            obj.vari_edge_dis=(obj.dv_degree_dis.*degree_v)/sum((obj.dv_degree_dis.*degree_v));
            obj.check_edge_dis=(obj.dc_degree_dis.*degree_c)/sum(obj.dc_degree_dis.*degree_c); 
            disp('Edge Distribution is Constructed !');
        end
        

        
        function Analyze(obj)
            %obj.G_constructor();            
            obj.degree_table_constuctor();
            obj.vari_check_table_constructor();
            obj.edge_distribution();
        end
        
    end
    
end

