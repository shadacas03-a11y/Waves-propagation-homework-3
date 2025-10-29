
% Define the three Jones vectors (up to normalization)
J1 = [2; 1i];      % Left-handed (CCW) ellipse
J2 = [2; -1i];     % Right-handed (CW) ellipse
J3 = (1/sqrt(2))*[2+1i; -2+1i];  % Tilted ellipse (45°)

% Choose which one to plot
E = J1;   % <-- Change to J2 or J3 to plot another case

% Time parameter (phase)
t = linspace(0, 2*pi, 400);

% Compute field components over time
Ex = real(E(1) * exp(1i*t));
Ey = real(E(2) * exp(1i*t));

% Plot the polarization ellipse
figure('Color','w','Position',[200 200 600 500]);
plot(Ex, Ey, 'LineWidth', 2);
hold on;

% Reference axes
plot([0 max(Ex)], [0 0], 'k--');
plot([0 0], [0 max(Ey)], 'k--');

% Appearance and labels
axis equal;
xlabel('E_x (arb. units)');
ylabel('E_y (arb. units)');
title('Polarization ellipse for Part (a)');
grid on;

% Optional: mark direction of rotation
idx = 20;
quiver(Ex(idx), Ey(idx), Ex(idx+5)-Ex(idx), Ey(idx+5)-Ey(idx), ...
0, 'MaxHeadSize', 1, 'Color', [0.9 0 0], 'LineWidth', 1.5);
text(0.1, 0.1, 'Rotation direction', 'Color',[0.9 0 0]);
