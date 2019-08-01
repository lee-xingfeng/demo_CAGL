warning off
clear all;
addpath(genpath('./lib'));
addpath(genpath('./core'));
ds = {'YALE_165n_1024d_15c_zscore_uni', 'jaffe_213n_676d_10c_uni'};

%index of dataset.
di = 1; % 1 or 2
data_file = fullfile(['raw_data/',ds{di}, '.mat']);
kernel_file = fullfile(['kernel_data/', ds{di},'_allkernel', '.mat']);
fprintf('\t ## DATA SET is %s ##\n', ds{di});
load(data_file);
load(kernel_file);

% you should tune beta and neighbor to obtain the best performance.
alpha = 6;
neighbor = floor(length(y)/length(unique(y))); %

%algorithm 1.
beta = 1; % ever-fixed
lambda = 1; % ever-fixed
[F, ypred, Z, w] = CAGL(K, y, beta, alpha, lambda, neighbor);
fprintf('\t ## beta=%d,neighbor=%d ##\n', alpha, neighbor);
[res] =  CalcMeasures(y,ypred);
fprintf('\t ## %d> ACC:%.4f   NMI:%.4f   Purity:%.4f ##\n', 1, res(1), res(2), res(3));
imagesc(Z);colormap(jet);axis off;colorbar

rmpath(genpath('./lib'));
rmpath(genpath('./core'));

