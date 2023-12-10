function output = Saturation_F(input)
F1 = input(1);
F2 = input(2);
F3 = input(3);
F4 = input(4);

global F_min F_max

F1 = min(F_max, max(F_min, F1));
F2 = min(F_max, max(F_min, F2));
F3 = min(F_max, max(F_min, F3));
F4 = min(F_max, max(F_min, F4));

output = [F1; F2; F3; F4];
end