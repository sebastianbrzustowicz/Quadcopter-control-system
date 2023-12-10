function output = Saturation_PWM(input)
PWM1 = input(1);
PWM2 = input(2);
PWM3 = input(3);
PWM4 = input(4);

global PWM_min PWM_max

PWM1 = min(PWM_max, max(PWM_min, PWM1));
PWM2 = min(PWM_max, max(PWM_min, PWM2));
PWM3 = min(PWM_max, max(PWM_min, PWM3));
PWM4 = min(PWM_max, max(PWM_min, PWM4));

output = [PWM1; PWM2; PWM3; PWM4];
end