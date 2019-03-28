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
        check_node_transform;
        vari_node_transform;
        vari_lt;
        p_vari_lt;
        check_lt;
        LLRTable;
        puncrate_c;
        channel_mapping_matrix;
        averaged_distribution_withAL_v;
        averaged_mutual_info;
        
    end
    
    
    methods
        function obj = LookupTable_Construction(check_distri_vec,vari_distri_vec,ChannelCluster,MaxIter,dc_max,dv_max,T,puncrate_c)
            obj.check_distri_vec=check_distri_vec;
            obj.vari_distri_vec=vari_distri_vec;
            obj.ChannelCluster=ChannelCluster;
            obj.MaxIter=MaxIter;
            obj.T=T;
            obj.dc_max=dc_max;
            obj.dv_max=dv_max;
            obj.check_node_transform=zeros(size(obj.check_distri_vec,2),obj.T,obj.MaxIter);
            obj.vari_node_transform=zeros(size(obj.vari_distri_vec,2),obj.T,obj.MaxIter);
            obj.puncrate_c=puncrate_c;
            obj.channel_mapping_matrix=zeros(obj.MaxIter,obj.T);
            obj.p_vari_lt=zeros(obj.MaxIter,obj.T);
            obj.averaged_mutual_info=zeros(1,obj.MaxIter);
        end
        
        function [CMapping,VMapping]=Mapping_Construction (obj,MaxRun)
            
            obj.ChannelCluster(:,obj.T/2+1:end)=rot90(obj.ChannelCluster(:,1:obj.T/2),2);
            obj.ChannelCluster=obj.ChannelCluster./sum(sum(obj.ChannelCluster));
            CProbJoinXT1=obj.ChannelCluster;
            CProbJoinXT2=CProbJoinXT1;   
            for S=1:obj.MaxIter
                %%%% Check Part
                for ii=1:obj.dc_max-2
                    [CMapping(S,ii),~,CProbJoinXT1] = BCNO( CProbJoinXT1,CProbJoinXT2,obj.T,MaxRun);
                end
                %%%% Check Node ----Message Alignment Part
                %[pda_join_x_z,obj.check_node_transform(:,:,S)] = Message_Rearrange( CMapping(S,:),obj.ChannelCluster,obj.check_distri_vec,obj.T,1);
                [ ~,pda_join_x_z,obj.check_node_transform(:,:,S)] = ckeck_node_message_aligen( CMapping(S,:),obj.check_distri_vec,obj.T );
                %%%%%%%Variable Part
                VProbJoinXT1=obj.ChannelCluster;
                CProbJoinXT1_da= pda_join_x_z;
                %VProbJoinXT1=pda_join_x_z;
                %%%%
                for jj=1:obj.dv_max
                    [VMapping(S,jj),~,VProbJoinXT1] = BVNO( VProbJoinXT1,CProbJoinXT1_da,obj.T,MaxRun);
                end
                %%%% Message AliPart
                %[pda_join_x_z,obj.vari_node_transform(:,:,S)] =  Message_Rearrange( VMapping(S,:),obj.ChannelCluster,obj.vari_distri_vec,obj.T,0 );
                [ ~,pda_join_x_z,obj.vari_node_transform(:,:,S)] = vari_node_message_aligen( VMapping(S,:),obj.ChannelCluster,obj.vari_distri_vec,obj.T );
                obj.averaged_distribution_withAL_v(:,:,S)=pda_join_x_z;
                obj.averaged_mutual_info(S)=Mutual_Information(pda_join_x_z);
                CProbJoinXT1=pda_join_x_z;
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
            plot(1:obj.MaxIter,obj.averaged_mutual_info);
            legend(['MI-Average with design Eb/N0 =' num2str(Eb_N0) 'dB']);
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
                
    end
    
end

