%% Propagation of Gaussian field for long distance (1000 mm)
clear; clc; close all;

% -----------------------------
% Parameters
% -----------------------------
sigma = 0.5;          % Gaussian std in mm
lambda = 500e-6;      % wavelength in mm
L = 5;                % computational window in mm
N = 1024;             % grid points
dz = 1000;            % propagation distance in mm

% -----------------------------
% Spatial grid
% -----------------------------
dx = L / N;
x = -L/2 : dx : L/2 - dx;
y = x;
[X, Y] = meshgrid(x, y);

% -----------------------------
% Initial Gaussian field
% -----------------------------
U0 = exp(-(X.^2 + Y.^2)/(2*sigma^2));

% -----------------------------
% 2D FFT (plane wave decomposition)
% -----------------------------
U_fft = fftshift(fft2(ifftshift(U0))) * dx^2;

% -----------------------------
% k-space axes
% -----------------------------
dk = 2*pi / L;             % rad/mm
kx = (-N/2:N/2-1) * dk;
ky = kx;
[KX, KY] = meshgrid(kx, ky);

k0 = 2*pi / lambda;        % free-space wavenumber in rad/mm
KZ = sqrt(k0^2 - KX.^2 - KY.^2); % kz for each plane wave

% -----------------------------
% Propagate plane waves
% -----------------------------
U_fft_prop = U_fft .* exp(1i * KZ * dz);

% -----------------------------
% Inverse FFT to get field at z1
% -----------------------------
U_z1 = fftshift(ifft2(ifftshift(U_fft_prop))) / dx^2; % inverse transform
I_z1 = abs(U_z1).^2;                                    % intensity

% -----------------------------
% Plot propagated field intensity
% -----------------------------
figure;
imagesc(x, y, I_z1);
axis image;
colormap hot;
colorbar;
xlabel('x (mm)');
ylabel('y (mm)');
title('|U(x,y; z1=1000 mm)|^2 - Propagated Gaussian field');
