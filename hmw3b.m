%% Numerical plane wave decomposition of Gaussian aperture
clear; clc; close all;

% -----------------------------
% Parameters
% -----------------------------
sigma = 0.5;          % Gaussian standard deviation in mm
lambda = 500e-6;      % wavelength in mm (500 nm)
L = 5;                % size of computational window in mm
N = 1024;             % number of points for FFT

% -----------------------------
% Spatial grid
% -----------------------------
dx = L / N;
x = -L/2 : dx : L/2 - dx;
y = x;
[X, Y] = meshgrid(x, y);

% -----------------------------
% Gaussian aperture field
% -----------------------------
U0 = exp(-(X.^2 + Y.^2)/(2*sigma^2));

% -----------------------------
% 2D FFT (plane wave decomposition)
% -----------------------------
U_fft = fftshift(fft2(ifftshift(U0)));
U_fft = U_fft * dx^2;          % scale for integral approximation
I_k = abs(U_fft).^2;           % square modulus

% -----------------------------
% Map FFT to kx, ky axes
% -----------------------------
dk = 2*pi / L;                  % spatial frequency step in rad/mm
kx = (-N/2:N/2-1) * dk;        % kx vector in rad/mm
ky = kx;
[KX, KY] = meshgrid(kx, ky);

% -----------------------------
% Plot plane wave decomposition intensity
% -----------------------------
figure;
x_vec = kx; y_vec = ky;  % vectors for imagesc
imagesc(x_vec, y_vec, I_k);
axis image;
colormap hot;
colorbar;
xlabel('k_x (rad/mm)');
ylabel('k_y (rad/mm)');
title('|U~(k_x,k_y)|^2 - Plane wave decomposition of Gaussian aperture');
