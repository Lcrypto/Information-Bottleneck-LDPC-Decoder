function y=f_b2d(n)
    
   %-----------------------------------------------------------------------
   %PROGRAMMER:
   %GORDON NANA KWESI AMOAKO
   %EMAIL: kwesiamoako@gmail.com || gsnka@yahoo.com
   %
   %You can contact me with any questions and feel free to modify to suit
   %you needs. I don't think this is the best though, but it's good.
   %-----------------------------------------------------------------------
   % Modified: 22 FEB 2012
   
   %MATLAB's bin2dec( ) function just converts whole binary numbers
   %This function f_b2d( ) provides an extended functionality of converting
   %numbers with binary fractions or binary fractions only to decimalnumbers
   %-----------------------------------------------------------------------
   
   %
   %INPUT: n, n is a String of Binary numbers e.g. f_b2d('11001.101') gives us 

   %OUTPUT: A Decimal Number
   %  
   %SAMPLE input and output
   %-------------------------------
   %f_b2d('11001.101')=25.6250
   %f_b2d('110000111.111111101')=391.9941
   %f_b2d('0.11001111101')= 0.8110
   
   %Converting the Number to String


    n=strtrim(n);
    numadd=0;
    t=length(n);

    %----------------------------------------------------------------------
    if isempty(find(n=='.'))
        y=bin2dec(n);     
    else
    %----------------------------------------------------------------------
        j=find(n=='.');

        i_part=n(1:j-1);
        f_part=n(j+1:end);
        
        % Look for the indices of the fraction part which are ones and
        % a simple computation on it to convert to decimal
        d_fpart=sum(0.5.^find(f_part=='1'));
        
        y=f_b2d(i_part)+d_fpart; % Concatenate the results

    %----------------------------------------------------------------------
    end