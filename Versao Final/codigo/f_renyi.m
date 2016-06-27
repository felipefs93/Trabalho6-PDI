function g = f_renyi(A, Alpha)
[M,N]=size(A);
if ~islogical(A) 
       A = im2uint8(A); 
end;
p = zeros(256,3);

for ii=1:256 
    p(ii,1)=ii-1; 
end;

p(:,2) = imhist(A); % calculate histogram counts
p (p(:,2)==0,:) = []; % remove zero entries in p
p(:,3) = p(:,2) ./ numel(A); % normalize p so that sum(p) is one.

%%%%%%%%% Renyi Entropy to calculate the Threshold %%%%%%%%%
ArgMax=0;
for t=1 : size(p)
    PA= sum(p(1:t,3));
    PB= 1-PA ;
    p1=p(1:t,3)/PA;
    p2=p(t+1: size(p),3)/PB;
    Ha=log2( sum ((p1.^Alpha)) )/(1-Alpha);
    Hb=log2( sum ((p2.^Alpha)) )/(1-Alpha);
    Hab = Ha + Hb;
    if ( Hab > ArgMax ) t_opt=p(t,1); ArgMax=Hab; end;
end;
f = double (A);
for i=1:M; for j=1:N; f(i,j)=0; if (A(i,j) >= t_opt) f(i,j)=1; end; end; end;

%%%%%%%%% Using Threshold_Renyi to find the edge detection of A %%%%%%%%%
m = 3; n = 3;
a0 = (m-1)/2;
b0 = (n-1)/2;
g=f; % For all pixel coordinates, x and y, do Set g(x, y) = f(x, y)
% Checking for edge pixels:
for y = b0+1 : N-b0;
for x = a0+1 : M-a0;
sum1 = 0;
for k=-b0:b0;
for j=-a0:a0;
if ( f(x,y) == f (x+j,y+k) ) sum1=sum1+1; end;
end;
end;
if ( sum1>6 ) g(x,y)=0; else g(x,y)=1; end;
end;
end;

