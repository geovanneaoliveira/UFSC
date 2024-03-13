a = "hello world";

x = 5;
y = 8;
z = 10;

ano = [1984 1986 1990];
v = [0:2:10];
v2 = [1:1000];
v3 = [1:100000000];
v4 = [0:3:21];

matriz = [1 2 3;
          4 5 6;
          7 8 9];

matriz2 = [1:3;4:6;7:9];

matriz3 = matriz*matriz2;
matriz3 = matriz.*matriz2;

%Comment

%{
  Comment block
%}

matriz4 = randi(10,3,3)

m4_33 = matriz4(3,3)
m4_col2 = matriz4(:,2)
m4_row3 = matriz4(3,:)

m4sep = matriz4(1:2,1:2)
vm4_1 = matriz4(1:2,1)
vm4_2 = matriz4(2:3,3)
matriz5 = [vm4_1 vm4_2]



