function y=d2b(n)


strtemp='';
strn=strtrim(num2str(n));



if n<0
    fprintf(' %f is not a valid number\n',n)
 
end


  while n~=0
    strtemp=strcat(num2str(mod(n,2)),strtemp);
    n=floor(n/2);
  end

  y=strtemp; 
