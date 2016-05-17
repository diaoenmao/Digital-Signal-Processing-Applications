function [a,e,I,X] = covpred(x, p, r)
x_pre=[];
X=[];
L = length(x);
for i=p+1:L
    if(i+r<=L)
        x_pre=[x_pre;x(i+r)];
    else
        x_pre=[x_pre;0];
    end
    X_temp = [];
    for j=1:p
        if(i-j>=1 && i-j<=L)
            X_temp = [X_temp x(i-j)];
        else
            X_temp = [X_temp 0];
        end
    end
    X=[X;X_temp];
end
a = -X\x_pre;
a = [1; a];
I = p+1+r:L+r;
temp_X = X*a(2:end);
e = [x(p+1+r:end);zeros(r,1)]+temp_X;
end