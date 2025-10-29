% FRAUNHOFER DIFFRACTION OF A SQUARE APERTURE (2D FFT)
clear; close all; clc;

% ---- Parameters ----
lambda = 500e-9;  % wavelength [m]
f = 0.1;          % focal length [m]
a = 5e-3;         % aperture side [m]

% ---- Sampling grid ----
N = 2048;         % grid size
L = 12e-3;        % physical size of aperture plane [m]
dx = L / N;
x = (-N/2:N/2-1) * dx;
[X, Y] = meshgrid(x, x);

% ---- Square aperture ----
A = double(abs(X) <= a/2 & abs(Y) <= a/2);

% ---- 2D FFT (Fraunhofer pattern) ----
U = fftshift(fft2(ifftshift(A))) * dx^2;

% ---- Spatial frequency and focal plane coordinates ----
fx = (-N/2:N/2-1) / L;
[Fx, Fy] = meshgrid(fx, fx);
Xf = lambda * f * Fx;
Yf = lambda * f * Fy;

% ---- Normalized intensity ----
I_num = abs(U).^2;
I_num = I_num / max(I_num(:));

% ---- Analytical intensity for comparison ----
I_anal = sinc(a * Xf / (lambda * f)).^2 .* sinc(a * Yf / (lambda * f)).^2;
I_anal = I_anal / max(I_anal(:));

% ---- Plot ----
figure;
subplot(1,2,1);
imagesc(Xf(1,:)*1e6, Yf(:,1)*1e6, I_num);
axis image; colormap hot; colorbar;
xlabel('x_f [µm]'); ylabel('y_f [µm]');
title('Numerical intensity (2D FFT)');

subplot(1,2,2);
imagesc(Xf(1,:)*1e6, Yf(:,1)*1e6, I_anal);
axis image; colormap hot; colorbar;
xlabel('x_f [µm]'); ylabel('y_f [µm]');
title('Analytical intensity (sinc^2)');

% ---- Print first zero position ----
x_zero = lambda * f / a;
fprintf('Theoretical first zero at x = %.2f µm\n', x_zero*1e6);

% After plotting:
imagesc(Xf(1,:)*1e6, Yf(:,1)*1e6, I_num);
axis image; colormap hot; colorbar;
xlabel('x_f [µm]'); ylabel('y_f [µm]');
xlim([-50 50]); ylim([-50 50]); % zoom on central lobe

