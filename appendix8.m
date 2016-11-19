n=10;r=2;change=0.7;kmax=100;


hold on
for i=1:n+1
    for j=1:n+1
        square(i,j)=0;
    end
end
f=0;cnt=0;k=0;
while(k<kmax)
    max=0;i1=0;j1=0;
    for i=1:n+1
        for j=1:n+1
            s=0;
            if square(i,j)==0
              for p=i-r:i+r
                for q=j-r:j+r
                    if p>0&p<=n+1&q>0&q<=n+1&sqrt((i-p)^2+(j-q)^2)<=r&square(p,q)==0
                        s=s+1;
                    end
                end
              end
            end
            if s>max
                max=s;i1=i;j1=j;
            end
        end
    end
    cnt=cnt+1;site(cnt,1)=i1;site(cnt,2)=j1;
            for p=i1-r:i1+r
                for q=j1-r:j1+r
                    if p>=1&p<=n+1&q>=1&q<=n+1&sqrt((i1-p)^2+(j1-q)^2)<=r
                        square(p,q)=1;
                    end
                end
            end
            f=1;
            for i=1:n+1
                for j=1:n+1
                    if square(i,j)==0
                       f=0;
                    end
                end
            end
   if f==1
       k=k+1;
       if k==1 || cnt<ans 
           ans=cnt;ans
           for i=1:cnt
               a(i,1)=site(i,1);a(i,2)=site(i,2);
           end
       end
       for i=1:cnt*change
           x=round(rand*(cnt-1))+1;
           for j=x:cnt-1
               site(j,1)=site(j+1,1);site(j,2)=site(j+1,2);
           end
           cnt=cnt-1;
       end
       for i=1:n+1
           for j=1:n+1
               square(i,j)=0;
           end
       end
           
       for i=1:cnt
           for p=site(i,1)-r:site(i,1)+r
               for q=site(i,2)-r:site(i,2)+r
                   if p>=1&p<=n+1&q>=1&q<=n+1&sqrt((site(i,1)-p)^2+(site(i,2)-q)^2)<=r
                       square(p,q)=1;f=0;
                   end
               end
           end
       end        
    end
end


rectangle('Position',[1,1,n,n])
for i=1:ans
    alpha=0:pi/20:2*pi;
    x=r*cos(alpha);
    y=r*sin(alpha);
    plot(x+a(i,1),y+a(i,2));
end

axis([-2 20 -2 20])



      
            
            
            