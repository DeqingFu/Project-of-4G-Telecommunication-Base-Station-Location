wide=10;high=10;r=2;

hold on
for i=1:high+1
    for j=1:wide+1
        square(i,j)=0;
    end
end
%calculate the upper bound by greedy algorithm
f=0;upperbound=0;
while(f==0)
    max=0;i1=0;j1=0;
    for i=1:high+1
        for j=1:wide+1
            s=0;
            if square(i,j)==0
              for p=i-r:i+r
                for q=j-r:j+r
                    if    p>0&p<=high+1&q>0&q<=wide+1&sqrt((i-p)^2+(j-q)^2)<=r&square(p,q)==0
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
    upperbound=upperbound+1;res(upperbound,1)=i1;res(upperbound,2)=j1;
            for p=i1-r:i1+r
                for q=j1-r:j1+r
                    if p>=1&p<=high+1&q>=1&q<=wide+1&sqrt((i1-p)^2+(j1-q)^2)<=r
                        square(p,q)=1;
                    end
                end
            end
            f=1;
            for i=1:high+1
                for j=1:wide+1
                    if square(i,j)==0
                       f=0;
                    end
                end
            end
end
ans=upperbound;
lowerbound=floor(high*wide/(pi*r^2))+1;  %calculate the lower bound

 % narrow the range by dichotomy 
while(lowerbound<upperbound) 
    k=floor((lowerbound+upperbound)/2);
    t=100000;tmin=0.0001;coolingrate=0.003;energy=0;
    for i=1:high+1
        for j=1:wide+1
            square(i,j)=0;
        end
    end
    %generate the initial solution
    for i=1:k
        posi(i,1)=0;posi(i,2)=0;f=0;p=0;
        while(posi(i,1)<1 || posi(i,1)>high+1 || posi(i,2)<1 || posi(i,2)>wide+1 || f==0&&p<100000)
            posi(i,1)=floor(rand*high)+1;posi(i,2)=floor(rand*wide)+1;
            f=1;p=p+1;
            for j=1:i-1
                if sqrt((posi(i,1)-posi(j,1))^2+(posi(i,2)-posi(j,2))^2)<1.5*r
                    f=0;
                end
            end
        end
        for p=floor(posi(i,1)-r):posi(i,1)+r
            for q=floor(posi(i,2)-r):posi(i,2)+r
                if p>=1&p<=high+1&q>=1&q<=wide+1&sqrt((posi(i,1)-p)^2+(posi(i,2)-q)^2)<=r
                    square(p,q)=1;
                end
            end
        end
    end
    for i=1:high+1
           for j=1:wide+1
              if square(i,j)==0 
                energy=energy+1;
            end
        end
    end
    
    %simulated annealing
    while(t>tmin&energy>0)
        change=floor(rand*(energy-1))+1;
        p=0;
        for i=1:high+1
           for j=1:wide+1
              if square(i,j)==0 
                p=p+1;
                if (p==change) 
                    i1=i;j1=j;break;
                end    
              end
           end 
           if (p==change) break;end
        end
        min=100000;minj=0;
        for i=1:k
              if sqrt((posi(i,1)-i1)^2+(posi(i,2)-j1)^2)<min  
                min=sqrt((posi(i,1)-i1)^2+(posi(i,2)-j1)^2);minj=i;
              end
        end
        ti=posi(minj,1);tj=posi(minj,2);
        posi(minj,1)=0;posi(minj,2)=0;
        while(posi(minj,1)<1 || posi(minj,1)>high+1 || posi(minj,2)<1 || posi(minj,2)>wide+1)
          alpha=rand*2*pi;dist=rand*r+0.01;  
          posi(minj,1)=i1+dist*cos(alpha);posi(minj,2)=j1+dist*sin(alpha);
        end
        for i=1:high+1
           for j=1:wide+1
             square(i,j)=0;
           end
        end
        for i=1:k
            for p=floor(posi(i,1)-r):posi(i,1)+r
                for q=floor(posi(i,2)-r):posi(i,2)+r
                   if p>=1&p<=high+1&q>=1&q<=wide+1&sqrt((posi(i,1)-p)^2+(posi(i,2)-q)^2)<=r
                     square(p,q)=1;
                   end 
                end
            end
        end
        newenergy=0;
        for i=1:high+1
           for j=1:wide+1
             if square(i,j)==0
                 newenergy=newenergy+1;
             end
           end
        end
    % jump out of the regional optimal value with a certain possibility
        if (newenergy<energy || (newenergy>=energy&rand<exp((energy-newenergy)/t)))
           energy=newenergy;
           
           if (energy==0)
               ans=k;
               for i=1:k
                   res(i,1)=posi(i,1);res(i,2)=posi(i,2);
               end
              
           end
        else
            posi(minj,1)=ti;posi(minj,2)=tj;
        end
        t=t*(1-coolingrate);
        
    end
    if (energy==0) 
        upperbound=k;
    else
        lowerbound=k+1;
    end
    
end
%print out
rectangle('Position',[2,2,wide,high],'Linewidth',3);
for i=1:ans
    alpha=0:pi/20:2*pi;
    x=r*cos(alpha);
    y=r*sin(alpha);
    plot(y+res(i,2)+1,x+res(i,1)+1,'Linewidth',3);
end
for i=2:2+n
    for j=2:2+n
        plot(i,j,'ro','MarkerFaceColor','r');
    end
end
axis([-1 20 -1 20])
