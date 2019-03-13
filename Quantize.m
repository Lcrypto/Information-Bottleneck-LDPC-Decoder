        %% qunatization part
        function [quan_val]= Quantize (Val, integer_bits, fractionbits)
            %%%This part is to simulate Quantization 
            %%%Input :   Val                Input-Value
            %%%          integer_bits       Number of Integers
            %%%          fraction_bits      Number of fraction bits 
            %%%Output    quan_val           qunatized_values
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
                    quan_val(ii)=max(abs_val,quan_max)+f_b2d(frac_bi(1:fractionbits+2));
                else        %% negtive num
                    quan_val(ii)=-(max(abs_val,quan_min)+f_b2d(frac_bi(1:fractionbits+2)));
                end
            end
        end