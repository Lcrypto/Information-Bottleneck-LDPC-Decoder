classdef LookupTable_Construction<handle
    %UNTITLED5 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        check_distri_vec;
        vari_distri_vec;
        ChannelCluster;       
        MaxIter;
        T;
        dc_max;
        dv_max;
        cmapping;
        vmapping;
        averaged_distribution_withAL_v;
        averaged_distribution_withoutAL_v;
        averaged_distribution_withAL_c;
        averaged_distribution_withoutAL_c;
        check_node_transform;
        vari_node_transform;
        vari_lt;
        check_lt;
        LLRTable;
        
    end
    
    
    methods
        function obj = LookupTable_Construction(check_distri_vec,vari_distri_vec,ChannelCluster,MaxIter,dc_max,dv_max,T)
            obj.check_distri_vec=check_distri_vec;
            obj.vari_distri_vec=vari_distri_vec;
            obj.ChannelCluster=ChannelCluster;
            obj.MaxIter=MaxIter;
            obj.T=T;
            obj.dc_max=dc_max;
            obj.dv_max=dv_max;
            obj.averaged_distribution_withAL_v=zeros(2,obj.T,obj.MaxIter);
            obj.averaged_distribution_withoutAL_v=zeros(2,obj.T,obj.MaxIter);
            obj.averaged_distribution_withAL_c=zeros(2,obj.T,obj.MaxIter);
            obj.averaged_distribution_withoutAL_c=zeros(2,obj.T,obj.MaxIter);
            obj.check_node_transform=zeros(length(obj.check_distri_vec),obj.T,obj.MaxIter);
            obj.vari_node_transform=zeros(length(obj.vari_distri_vec),obj.T,obj.MaxIter);
        end
        
        function [CMapping,VMapping]=Mapping_Construction (obj,MaxRun)

            CProbJoinXT1=obj.ChannelCluster;
            CProbJoinXT2=CProbJoinXT1;            
            for S=1:obj.MaxIter
                for ii=1:obj.dc_max-2
                    [CMapping(S,ii),CCluster(S,ii),CProbJoinXT1] = BCNO( CProbJoinXT1,CProbJoinXT2,obj.T,MaxRun);
                end
                %%%% Message Alignment Part
                [ new_Cmapping,pda_join_x_z,obj.check_node_transform(:,:,S)] = ckeck_node_message_aligen( CMapping(S,:),obj.check_distri_vec,obj.T );
                [ obj.averaged_distribution_withAL_c(:,:,S) ] = average_distribution( obj.check_distri_vec,new_Cmapping,0,obj.T);
                [ Cost_withAL_c ] = additional_mi( obj.check_distri_vec,new_Cmapping,0,obj.averaged_distribution_withAL_c(:,:,S) ,obj.T );
                [ obj.averaged_distribution_withoutAL_c(:,:,S) ] = average_distribution( obj.check_distri_vec,CMapping(S,:),0,obj.T);
                [ Cost_withoutAL_c ] = additional_mi( obj.check_distri_vec,CMapping(S,:),0,obj.averaged_distribution_withoutAL_c(:,:,S),obj.T );
                [cost_dif_c(S)]=Cost_withoutAL_c-Cost_withAL_c;
                VProbJoinXT1=obj.ChannelCluster;
                CProbJoinXT1_da=obj.averaged_distribution_withAL_c(:,:,S);
                %%%%
                for jj=1:obj.dv_max
                    [VMapping(S,jj),Vluster(S,jj),VProbJoinXT1] = BVNO( VProbJoinXT1,CProbJoinXT1_da,obj.T,MaxRun);
                end
                %%%% Message AliPart
                [ new_Cmapping,pda_join_x_z,obj.vari_node_transform(:,:,S)] = vari_node_message_aligen( VMapping(S,:),obj.vari_distri_vec,obj.T );
                [ obj.averaged_distribution_withAL_v(:,:,S) ] = average_distribution( obj.vari_distri_vec,new_Cmapping,1,obj.T);
                [ obj.averaged_distribution_withoutAL_v(:,:,S) ] = average_distribution( obj.vari_distri_vec,VMapping(S,:),1,obj.T);
                [ Cost_withAL_v ] = additional_mi( obj.vari_distri_vec,new_Cmapping,1,obj.averaged_distribution_withAL_v(:,:,S),obj.T );
                [ Cost_withoutAL_v ] = additional_mi( obj.vari_distri_vec,VMapping(S,:),1, obj.averaged_distribution_withoutAL_v(:,:,S),obj.T );
                [cost_dif_v(S)]=Cost_withAL_v-Cost_withoutAL_v;
                CProbJoinXT1=obj.averaged_distribution_withAL_v(:,:,S);
                CProbJoinXT2=CProbJoinXT1;
                display(num2str(S));
            end
            obj.cmapping=CMapping;
            obj.vmapping=VMapping;
            
        end
        
        function [vari_lt,check_lt]=lt_construction(obj,CMapping,VMapping)            
            %%%%This function is used to construct look-up table
            vari_lt=cell(obj.MaxIter,obj.dv_max);
            check_lt=cell(obj.MaxIter,obj.dc_max-2);
            for ii=1:obj.MaxIter
                for jj=1:obj.dv_max         %% CONSTRUCT  variable node lookup table
                    vari_lt{ii,jj}=lookup_table_matrix(VMapping(ii,jj).Combo, VMapping(ii,jj).ProbConTT1T2,obj.T);
                end
            end            
            for ii=1:obj.MaxIter
                for jj=1:obj.dc_max-2
                    check_lt{ii,jj}=lookup_table_matrix(CMapping(ii,jj).Combo,CMapping(ii,jj).ProbConTT1T2,obj.T);
                end
            end
            obj.vari_lt=vari_lt;
            obj.check_lt=check_lt;            
        end
        
        function mutual_information_plot(obj,Eb_N0)            
            mi_average=zeros(1,obj.MaxIter);
            mi_lastoutput=zeros(1,obj.MaxIter);
            for ii=1:obj.MaxIter
                mi_average(ii)=Mutual_Information(obj.averaged_distribution_withAL_v(:,:,ii));
                mi_lastoutput(ii)=Mutual_Information(obj.vmapping(ii,obj.dv_max).NProbJoinXT);
            end
            plot(1:obj.MaxIter,mi_average);
            hold on;
            plot(1:obj.MaxIter,mi_lastoutput);
            legend(['MI-Average with design Eb/N0 =' num2str(Eb_N0) 'dB'],['MI-last output with design Eb/N0 =' num2str(Eb_N0) 'dB']);
            xlabel('Iteration Time');
            ylabel('I(X_v^{out};T_v^{out})');
            grid on;                                 
        end
        
        function LLR_Table(obj)
           
            for ii=1:obj.dv_max
                obj.LLRTable(ii,:)=log((obj.vmapping(obj.MaxIter,ii).NProbJoinXT(1,:))./(obj.vmapping(obj.MaxIter,ii).NProbJoinXT(2,:)));
            end
            
        end
        
        function [movie_handle]=movie_distributions(obj,distribution)                                   
            for ii=1:obj.MaxIter
                cla reset;
                plot(sum(distribution(:,:,ii)));
                movie_handle(ii)=getframe;
                hold on;
                pause(0.1);
            end            
        end
        
        function transform_modi (obj)
            %obj.T=obj.T+2;
            [row,col,pp]=size(obj.vari_node_transform);
            Vari_node_transform=zeros(row,col+2,pp);            
            for kk=1:pp
                Vari_node_transform(:,:,kk)=obj.trans_change(obj.vari_node_transform(:,:,kk),16);
            end  
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            [row,col,pp]=size(obj.check_node_transform);
            Check_node_transform=zeros(row,col+2,pp);
            for kk=1:pp
                Check_node_transform(:,:,kk)=obj.trans_change(obj.check_node_transform(:,:,kk),16);
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            obj.vari_node_transform=Vari_node_transform;
            obj.check_node_transform=Check_node_transform;
            
        end
        
        function [new_matrix]=trans_change (obj,matrix,T)
            [row,col]=size(matrix);
            matrix=[matrix(:,1:T/2) (T/2+1)*ones(row,1) (T/2+2)*ones(row,1) matrix(:,T/2+1:end)];
            for ii=1:row
                for jj=1:col+2
                    if (jj~=T/2+1 && jj~=T/2+2)
                        if (matrix(ii,jj)>T/2)
                            matrix(ii,jj)=matrix(ii,jj)+2;
                        end
                    end
                end
            end
            new_matrix=matrix;
        end
        
        function LLR_modi(obj)
            [row,col]=size(obj.LLRTable);
            
            new_llr_table=[obj.LLRTable(:,1:col/2) zeros(row,2) obj.LLRTable(:,col/2+1:end)];
            obj.LLRTable=new_llr_table;
        end
    end
    
end

