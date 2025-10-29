%% (b) Polarization ellipse for the given Jones vector
clear; clc; close all;

% --- Jones vector given ---
u = [2; -3i] / sqrt(5);

% --- Compute amplitudes and phase difference ---
Ax = abs(u(1));
Ay = abs(u(2));
phi_x = angle(u(1));
phi_y = angle(u(2));
delta = phi_y - phi_x;

% --- Time parameter ---
t = linspace(0, 2*pi, 400);

% --- Electric field components ---
Ex = Ax * cos(t);
Ey = Ay * cos(t + delta);

% --- Plot polarization ellipse ---
figure;
plot(Ex, Ey, 'b', 'LineWidth', 2); hold on;
axis equal; grid on;
xlabel('E_x'); ylabel('E_y');
title('Polarization ellipse for u');
legend('u = (1/\surd5)[2; -3i]', 'Location', 'best');

% --- Add direction arrow ---
quiver(Ex(1), Ey(1), Ex(10)-Ex(1), Ey(10)-Ey(1), 0, 'b', 'LineWidth', 1.2, 'MaxHeadSize', 1);

% --- Display parameters ---
fprintf('Polarization state u:\n');
fprintf('A_x = %.4f, A_y = %.4f, δ = %.4f rad\n', Ax, Ay, delta);
