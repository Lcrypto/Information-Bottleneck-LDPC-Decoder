A=zeros(2,16,10);
for ii=1:10
prompt = 'What is the original value? ';
A(:,:,ii) = input(prompt).';
end