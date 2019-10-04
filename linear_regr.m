y = [ 164
163
180
179
162
169
160
185
171
190
166 ]; % Height

x = [ 39
38
43
42
36
41
37
44
40
45
39 ]; % Shoe size


n = length(y);

X = ones(n,2);

for i=1:n
   X(i,2)=x(i); 
end

beta_hat = inv(X'*X)*X'*y % Solution

for i=1:n
y_hat_transp(i) = beta_hat(1) + beta_hat(2)*x(i);
end

y_hat = y_hat_transp';

plot(x,y,'o',x,y_hat);

[r,m,b] = regression(x',y')