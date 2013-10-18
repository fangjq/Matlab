clc, clear all;
A = [3 2 2 1 1 1];
[m, n] = size(A);
num_nodes = 2 * n - 1;
prob = zeros(1, num_nodes);
prob(1:n) = A;

num_used = n;
[~, index] = sort(prob(1:num_used), 'ascend');

left = zeros(1, num_nodes);
right = zeros(1, num_nodes);
up = zeros(1, num_nodes);

k = n + 1;
while num_used > 1
    node1 = index(1);
    node2 = index(2);
    prob(k) = prob(node1) + prob(node2);
    left(k) = node1;
    right(k) = node2;
    up(node2) = -k;
    up(node1) = k;
    
    index(1) = k; 
    index(2) = index(num_used);
    num_used = num_used - 1;
    k = k + 1;

    [~, ind] = sort(prob(index(1:num_used)), 'ascend');
    index(1:num_used) = index(ind);
end
code = cell(1, 6);
for i = 1 : n
    node = up(i);
    while node ~= 0
        if node < 0
            code(i) = {[cell2mat(code(i)) '1']};
            node = -node;
        else
            code(i) = {[cell2mat(code(i)) '0']};
        end
        node = up(node);
    end
end
code