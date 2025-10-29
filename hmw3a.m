%% Plane wave decomposition of a 2D Gaussian
clear; clc; close all;

sigma = 1; % standard deviation in mm (adjust as needed)

% Define kx, ky vectors
kmax = 5/sigma; % range for plotting
Nk = 200;
kx = linspace(-kmax, kmax, Nk);
ky = linspace(-kmax, kmax, Nk);
[KX, KY] = meshgrid(kx, ky);

% Plane wave decomposition (Fourier transform)
U_k = (sigma^2 / (2*pi)) * exp(-(KX.^2 + KY.^2) * sigma^2 / 2);

% Plot intensity
figure;
imagesc(kx, ky, abs(U_k));
axis image;
colorbar;
xlabel('k_x (1/mm)');
ylabel('k_y (1/mm)');
title('Plane wave decomposition of 2D Gaussian');
colormap hot;
