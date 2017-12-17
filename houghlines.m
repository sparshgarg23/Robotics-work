function [h,rho,theta]=houghlines(varargin)


[bw, rho, theta] = parseInputs(varargin{:});

h = houghmex(bw,rho,theta*pi/180);
end
function [bw, rho, theta] = parseInputs(varargin)

narginchk(1,5);

bw = varargin{1};


if ~islogical(bw)
    bw = bw~=0;
end

% Set the defaults
thetaResolution = 1;
rhoResolution = 1;
theta = [];


% Compute theta and rho
[M,N] = size(bw);

if (isempty(theta))
    theta = linspace(-90, 0, ceil(90/thetaResolution) + 1);
    theta = [theta -fliplr(theta(2:end - 1))];
end

D = sqrt((M - 1)^2 + (N - 1)^2);
q = ceil(D/rhoResolution);
nrho = 2*q + 1;
rho = linspace(-q*rhoResolution, q*rhoResolution, nrho);
end