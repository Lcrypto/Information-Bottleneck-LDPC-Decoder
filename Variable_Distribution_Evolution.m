classdef Variable_Distribution_Evolution<handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        punc_rate_ch;
        vari_distri_vec; 
        chec_distri_vec;
        punc_c;
        punc_v;
        dist_evo;
        output_dist_evo;
    end
    
    methods
        function obj=Variable_Distribution_Evolution(punc_rate_ch,vari_distri_vec,chec_distri_vec)
            obj.punc_rate_ch=punc_rate_ch;
            obj.vari_distri_vec=vari_distri_vec;
            obj.chec_distri_vec=chec_distri_vec;
        end
        
        function [Val]= distric_func(obj,dist_vec,input)
            Val=0;
            for ii=1:length(dist_vec)
                Val=Val+dist_vec(ii)*input^(ii-1);
            end
        end
        
        function dis_evolution(obj,iter_num)
            obj.punc_c=zeros(1,iter_num);
            obj.punc_v=zeros(1,iter_num);
            obj.dist_evo=zeros(iter_num+1,length(obj.vari_distri_vec)+1);
            obj.dist_evo(1,2:end)=obj.vari_distri_vec;
            obj.output_dist_evo=zeros(iter_num,length(obj.vari_distri_vec));
            for ii=1:iter_num
                if ii==1
                    obj.punc_c(ii)=1-obj.distric_func(obj.chec_distri_vec,1-obj.punc_rate_ch);
                else
                    obj.punc_c(ii)=1-obj.distric_func(obj.chec_distri_vec,1-obj.punc_v(ii-1));
                end
                obj.punc_v(ii)=obj.punc_rate_ch*obj.distric_func(obj.vari_distri_vec,obj.punc_c(ii));
                %%%%Update distribution under current iteration
                for kk=1:length(obj.vari_distri_vec)+1  %%prob of degree k-1
                    for jj=1:length(obj.vari_distri_vec)
                        if jj>=kk-1
                        obj.dist_evo(ii+1,kk)=obj.dist_evo(ii+1,kk)+obj.vari_distri_vec(jj)*nchoosek(jj,kk-1)*(1-obj.punc_c(ii))^(kk-1)*obj.punc_c(ii)^(jj-kk+1);
                        end
                    end
                end
                %%%%Update outcoming message distribution
                for kk=1:length(obj.vari_distri_vec)+1  %%calclate the rate of edges which have (k-1) non-zero neighbors 
                    for jj=1:length(obj.vari_distri_vec) %% vari degree j nodes 
                        if jj-1>=(kk-1)
                            obj.output_dist_evo(ii,kk)=obj.output_dist_evo(ii,kk)+obj.vari_distri_vec(jj)*nchoosek(jj-1,kk-1)*(1-obj.punc_c(ii))^(kk-1)*(obj.punc_c(ii))^((jj-1)-(kk-1));                            
                        end
                    end
                end
                
            end                        
        end 
        
        function Plot_Analyzer(obj)
            figure;
            grid on;
            Figuresetting;
            iter_num=length(obj.punc_c);
            plot(1:iter_num,obj.punc_c,1:iter_num,obj.punc_v);
            legend('zero message rate from check node','zero message rate from variable node');
            xlabel('Iteration Time');

            
            figure;
            grid on;
            Figuresetting;
            bar3(obj.dist_evo(2:end,:),'stacked');
         
            zlim([0 1]);
            legend('Degree-0','Degree-1','Degree-2','Degree-3','Degree-4','Degree-5','Degree-6');
            legend show;
            ylabel('Iteration Times');
            zlabel('Equivalent Variable Distribution')
            
%             for ii=2:iter_num+1
%                 bar3();
%                 hold on;
%             end

            figure;
            grid on;
            Figuresetting;
            bar3(obj.output_dist_evo,'stacked');

            legend('0 Neighbor','1 Neighbor','2 Neighbors','3 Neighbors','4 Neighbors','5 Neighbors');
           
            zlim([0 1]);
            ylabel('Iteration Times');
            zlabel('Rate of Neighbors')
            
            legend show;
            
            
        end
        
    end
    
end

