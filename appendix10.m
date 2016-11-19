A=imread('D:\32.jpg'); 
A=rgb2gray(A);
 
[n m]=size(A);
for i=1:n
    for j=1:m
        A1(i,j)=0;
    end
end
imin=n;imax=0;jmin=m;jmax=0;cnt=0;
for i=1:n
    p=1;
    while(A(i,p)==255 & p<m) p=p+1;end
    if (p<m)
        q=m;imax=i;if i<imin  imin=i;end
        while(A(i,q)==255 & q>p) q=q-1;end
        if p<jmin jmin=p;end
        if q>jmax jmax=q;end
        for j=p:q
            A1(i,j)=1;
        end
    end
end
 
n=1;cnt=0;
a(1)=541;b(1)=302;r=30;
while (a(n) >= 2*sqrt(2)*r & b(n) >= 2*sqrt(2)*r)
    alpha(n) = acos((a(n) - 2 * r * sqrt(2)) / (2 *r* ceil(a(n) / sqrt(2)/r - 2)));
    beta(n) = acos((b(n) - 2 * r * sqrt(2)) / (2 *r* ceil(b(n) / sqrt(2)/r - 2)));
    a(n + 1) = a(n) - 2*r*(cos(beta(n))+sin(beta(n)))*(cos(beta(n))+sqrt(2)/2)/(sqrt(2)+cos(beta(n))-sin(beta(n)));
    b(n + 1) = b(n) -2*r* (cos(alpha(n))+sin(alpha(n)))*(cos(alpha(n))+sqrt(2)/2)/(sqrt(2)+cos(alpha(n))-sin(alpha(n)));
    N(n + 1) = (ceil(a(n + 1) / sqrt(2)/r - 2) + ceil(b(n + 1) / sqrt(2)/r - 2)) * 2 + 4;
    T=0;
    for i=1:n-1
        T=T+r*(cos(alpha(i))+sin(alpha(i)))*(cos(alpha(i))+sqrt(2)/2)/(sqrt(2)+cos(alpha(i))-sin(alpha(i)));
    end
    S=0;
    for i=1:n-1
        S=S+r*(cos(beta(i))+sin(beta(i)))*(cos(beta(i))+sqrt(2)/2)/(sqrt(2)+cos(beta(i))-sin(beta(i)));
    end    
    
    cnt=cnt+1;
    circle(cnt,1)=T+r*sqrt(2)/2;circle(cnt,2)=a(n)-r*sqrt(2)/2+S;
    cnt=cnt+1;
    circle(cnt,1)=T+r*sqrt(2)/2;circle(cnt,2)=S+r*sqrt(2)/2;
    cnt=cnt+1;
    circle(cnt,1)=T+b(n)-r*sqrt(2)/2;circle(cnt,2)=a(n)-r*sqrt(2)/2+S;
    cnt=cnt+1;
    circle(cnt,1)=T+b(n)-r*sqrt(2)/2;circle(cnt,2)=S+r*sqrt(2)/2;
  
    for p=1:ceil(b(n)/sqrt(2)/r-2)
        cnt=cnt+1;
        circle(cnt,1)=T+r*sqrt(2)+r*(2*p-1)*cos(beta(n));circle(cnt,2)=a(n)-r*sin(beta(n))+S;
        cnt=cnt+1;
        circle(cnt,1)=T+r*sqrt(2)+r*(2*p-1)*cos(beta(n));circle(cnt,2)=r*sin(beta(n))+S;
    end
    for q=1:ceil(a(n)/sqrt(2)/r-2)
        cnt=cnt+1;
        circle(cnt,1)=T+b(n)-r*sin(alpha(n));circle(cnt,2)=r*sqrt(2)+r*(2*q-1)*cos(alpha(n))+S;
        cnt=cnt+1;
        circle(cnt,1)=T+r*sin(alpha(n));circle(cnt,2)=r*sqrt(2)+r*(2*q-1)*cos(alpha(n))+S;
    end
     n=n+1;
end
 T=0;
    for i=1:n-1
        T=T+r*(cos(alpha(i))+sin(alpha(i)))*(cos(alpha(i))+sqrt(2)/2)/(sqrt(2)+cos(alpha(i))-sin(alpha(i)));
    end
    S=0;
    for i=1:n-1
        S=S+r*(cos(beta(i))+sin(beta(i)))*(cos(beta(i))+sqrt(2)/2)/(sqrt(2)+cos(beta(i))-sin(beta(i)));
    end
if a(n)<=r*2*sqrt(2)
    if a(n)>r*sqrt(2)
        for p=1:ceil(b(n)/sqrt(2)/r);
            cnt=cnt+1;
            circle(cnt,1)=T+(b(n)/(ceil(b(n)/sqrt(2)/r)))*(2*p-1)/2;circle(cnt,2)=sqrt(1-(b(n)/(ceil(b(n)/sqrt(2)/r)))*(b(n)/(ceil(b(n)/sqrt(2)/r)))/4)+S;
            cnt=cnt+1;
        circle(cnt,1)=T+(b(n)/(ceil(b(n)/sqrt(2)/r)))*(2*p-1)/2;circle(cnt,2)=a(n)-sqrt(1-(b(n)/(ceil(b(n)/sqrt(2)/r)))*(b(n)/(ceil(b(n)/sqrt(2)/r)))/4)+S;
        end
        
    else
        for p=1:ceil(b(n)/sqrt(2)/r);
            cnt=cnt+1;
            circle(cnt,1)=T+(b(n)/(ceil(b(n)/sqrt(2)/r)))*(2*p-1)/2;circle(cnt,2)=a(1)/2;
        end
    end
else
    if b(n)>r*sqrt(2)
        for p=1:ceil(a(n)/sqrt(2)/r);
            cnt=cnt+1;
            circle(cnt,2)=T+(a(n)/(ceil(a(n)/sqrt(2)/r)))*(2*p-1)/2;circle(cnt,1)=sqrt(1-(a(n)/(ceil(a(n)/sqrt(2)/r)))*(a(n)/(ceil(a(n)/sqrt(2)/r)))/4)+S;
            cnt=cnt+1;
        circle(cnt,2)=T+(a(n)/(ceil(a(n)/sqrt(2)/r)))*(2*p-1)/2;circle(cnt,1)=b(n)-sqrt(1-(a(n)/(ceil(a(n)/sqrt(2)/r)))*(a(n)/(ceil(a(n)/sqrt(2)/r)))/4)+S;
        end
        
    else
        for p=1:ceil(a(n)/sqrt(2)/r);
            cnt=cnt+1;
            circle(cnt,2)=T+(a(n)/(ceil(a(n)/sqrt(2)/r)))*(2*p-1)/2;circle(cnt,1)=b(1)/2;
        end
    end
end
[n m]=size(A);r=30;
for i=1:cnt
    p1=imax-floor(circle(i,2))+1;
    q1=floor((circle(i,1)+1))+jmin;
    circle(i,1)=p1;circle(i,2)=q1;
 
end
 
for i=1:cnt
    
    if (A1(circle(i,1),circle(i,2))==0)
        
        for j=i:cnt-1
            circle(j,1)=circle(j+1,1);
            circle(j,2)=circle(j+1,2);
        end
        cnt=cnt-1;
        i=i-1;
    end
end
 
res=cnt;
cnt=0;
for i=imin:imax
    for j=jmin:jmax
      if (A1(i,j)==1)
           f=0;
           for p=1:res     
                if sqrt((circle(p,1)-i)^2+(circle(p,2)-j)^2)<=r
                     f=1;break;
                end              
           end
           
           if f==0 A1(i,j)=2;cnt=cnt+1;posi(cnt,1)=i;posi(cnt,2)=j;end
      end
    end
end
 
f=0;
if cnt==0 f=1;end
while(f==0)
    max=0;i1=0;
    for i=1:cnt
        
            s=0;
        if A1(posi(i,1),posi(i,2))==2
              for p=posi(i,1)-r:posi(i,1)+r
                for q=posi(i,2)-r:posi(i,2)+r
                    if p>imin&p<=imax&q>jmin&q<=jmax&sqrt((posi(i,1)-p)^2+(posi(i,2)-q)^2)<=r&A1(p,q)==2
                        s=s+1;
                    end
                end
              end
            
            if s>max
                max=s;i1=i;
            end
        end
    end
    res=res+1;circle(res,1)=posi(i1,1);circle(res,2)=posi(i1,2);
            for p=posi(i1,1)-r:posi(i1,1)+r
                for q=posi(i1,2)-r:posi(i1,2)+r
                    if p>=imin&p<=imax&q>=jmin&q<=jmax&sqrt((posi(i1,1)-p)^2+(posi(i1,2)-q)^2)<=r
                        A1(p,q)=1;
                    end
                end
            end
            f=1;
            for i=1:cnt
                
                    if A1(posi(i,1),posi(i,2))==2
                       f=0;break;
                    end
              
            end
end
for i=1:res
     
    for p=floor(circle(i,1)-r):circle(i,1)+r
        for q=floor(circle(i,2)-r):circle(i,2)+r
            if p>1&p<n&q>1&q<m&abs(sqrt((p-circle(i,1))^2+(q-circle(i,2))^2)-r)<1
                A(p,q)=0;
            end
        end
    end
end
disp(res);
imshow(A);
