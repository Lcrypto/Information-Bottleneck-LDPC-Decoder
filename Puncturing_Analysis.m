classdef Puncturing_Analysis<handle
    %UNTITLED2 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        vari_distri;
        check_distri;
        punc_distri;
        iter_num;
    end
    
    properties
        e;
        epsilong;
        theta_0;
        theta_p;
        theta_np;
        test_res;
    end
    
    methods
        function obj=Puncturing_Analysis(vari_distri,check_distri,punc_distri,iter_num)
            obj.vari_distri=vari_distri;
            obj.check_distri=check_distri;
            obj.punc_distri=punc_distri;
            obj.iter_num=iter_num;
        end
        
        function [Val]= distric_func(obj,dist_vec,input)
            Val=0;
            for ii=1:length(dist_vec)
                Val=Val+dist_vec(ii)*input^(ii-1);
            end
        end
        
        function zero_msg_prob_evo(obj)
            obj.e=zeros(1,obj.iter_num);
            obj.epsilong=zeros(1,obj.epsilong);
            vari_pun=obj.vari_distri.*obj.punc_distri;
            for kk=1:obj.iter_num
                if kk==1
                    obj.e(kk)=obj.distric_func(vari_pun,1);
                else
                    obj.e(kk)=obj.distric_func(vari_pun,obj.epsilong(kk-1));
                end
                obj.epsilong(kk)=1-obj.distric_func(obj.check_distri,(1-obj.e(kk)));
            end            
        end
        
        function theta_evo(obj)
            obj.theta_0=zeros(obj.iter_num,1);
            obj.theta_p=zeros(obj.iter_num,length(obj.vari_distri));
            obj.theta_np=zeros(size(obj.theta_p));
            vari_p=obj.vari_distri.*obj.punc_distri;
            vari_np=obj.vari_distri.*(1-obj.punc_distri);
            %%%%
            for kk=1:obj.iter_num
                if kk==1
                obj.theta_0(kk)=obj.distric_func(vari_np,1);
                else
                obj.theta_0(kk)=obj.distric_func(vari_np,obj.epsilong(kk-1));
                end
            end
            %%%%
            for kk=1:obj.iter_num
                if kk==1
                    cur_ep=1;
                else
                    cur_ep=obj.epsilong(kk-1);
                end
                for jj=1:length(obj.vari_distri)
                    for hh=jj+1:length(obj.vari_distri)
                       obj.theta_p(kk,jj)=obj.theta_p(kk,jj)+vari_p(hh)*nchoosek(hh-1,jj)*(cur_ep)^(hh-1-jj)*(1-cur_ep)^(jj);
                       obj.theta_np(kk,jj)=obj.theta_np(kk,jj)+vari_np(hh)*nchoosek(hh-1,jj)*(cur_ep)^(hh-1-jj)*(1-cur_ep)^(jj);
                    end
                end
            end
            for ii=1:obj.iter_num
                Sum=obj.theta_0(ii)+sum(obj.theta_p(ii,:))+sum(obj.theta_np(ii,:));
                obj.theta_0(ii)=obj.theta_0(ii)./Sum;
                obj.theta_p(ii,:)=obj.theta_p(ii,:)/Sum;
                obj.theta_np(ii,:)=obj.theta_np(ii,:)/Sum;
            end
        end

        
        function go(obj)
            zero_msg_prob_evo(obj);
            theta_evo(obj);         
        end
        
    end
    
end

