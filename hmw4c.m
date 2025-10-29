%% (c) Orthogonal polarization state
clear; clc; close all;

% --- Given vector u ---
u = [2; -3i] / sqrt(5);

% --- Construct orthogonal vector v (satisfies v†u = 0) ---
v = [-3i; 2] / sqrt(5);

% --- Verify orthogonality ---
inner = v' * conj(u);
disp('Inner product <v|u> =');
disp(inner);   % should be 0

% --- Compute amplitudes and phases ---
Ax_u = abs(u(1)); Ay_u = abs(u(2));
phi_x_u = angle(u(1)); phi_y_u = angle(u(2));
delta_u = phi_y_u - phi_x_u;

Ax_v = abs(v(1)); Ay_v = abs(v(2));
phi_x_v = angle(v(1)); phi_y_v = angle(v(2));
delta_v = phi_y_v - phi_x_v;

% --- Time vector ---
t = linspace(0, 2*pi, 400);

% --- Field components ---
Ex_u = Ax_u * cos(t);
Ey_u = Ay_u * cos(t + delta_u);

Ex_v = Ax_v * cos(t);
Ey_v = Ay_v * cos(t + delta_v);

% --- Plot both ellipses ---
figure;
plot(Ex_u, Ey_u, 'b', 'LineWidth', 2); hold on;
plot(Ex_v, Ey_v, 'r--', 'LineWidth', 2);
axis equal; grid on;
xlabel('E_x'); ylabel('E_y');
title('Orthogonal polarization ellipses');
legend({'u: δ = -π/2 (CCW)', 'v: δ = +π/2 (CW)'}, 'Location', 'best');

% --- Add arrows for direction ---
quiver(Ex_u(1), Ey_u(1), Ex_u(10)-Ex_u(1), Ey_u(10)-Ey_u(1), 0, 'b', 'LineWidth', 1.2, 'MaxHeadSize', 1);
quiver(Ex_v(1), Ey_v(1), Ex_v(10)-Ex_v(1), Ey_v(10)-Ey_v(1), 0, 'r', 'LineWidth', 1.2, 'MaxHeadSize', 1);

% --- Show parameters ---
fprintf('\nOriginal polarization u:\n');
fprintf('A_x = %.4f, A_y = %.4f, δ = %.4f rad\n', Ax_u, Ay_u, delta_u);
fprintf('\nOrthogonal polarization v:\n');
fprintf('A_x = %.4f, A_y = %.4f, δ = %.4f rad\n', Ax_v, Ay_v, delta_v);
