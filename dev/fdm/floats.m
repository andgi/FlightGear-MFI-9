%%
%% MFI-9B estimation of float planing.
%%
%%   Copyright (C) 2015  Anders Gidenstam  (anders(at)gidenstam.org)
%%
%%   This program is free software; you can redistribute it and/or modify
%%   it under the terms of the GNU General Public License as published by
%%   the Free Software Foundation; either version 2 of the License, or
%%   (at your option) any later version.
%% 
%%   This program is distributed in the hope that it will be useful,
%%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%%   GNU General Public License for more details.
%%  
%%   You should have received a copy of the GNU General Public License
%%   along with this program; if not, write to the Free Software
%%   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
%%

deg = pi/180;

%% Float RP is at the top of the float at the step.

%% Cases
tau = (0:13)*deg;
h_RP = 0.0;

%% Fore body as straight V-shaped profile of width b_f.
%% NOTE: In reality it is curved.
p0_f = -2.38;
p1_f =  0.00;
zk_f = -0.50;
b_f  = 0.58;
Deadrise=16*deg;
ForeBody = [p0_f p1_f];

%% Aft body
%% NOTE: It is straight in reality but should really have a different tau.
p0_a =  0.00;
p1_a =  2.16;
zk_a = -0.25;
b_a  =  0.58;
AftBody = [p0_a p1_a];

%% Entry points of the planing surfaces along the float x-axis.
xe_f = (h_RP./cos(tau) + zk_f)./tan(tau);
xe_a = (h_RP./cos(tau) + zk_a)./tan(tau);

%% Wetted keel lengths
Lk_f = max(0, min(p1_f - xe_f, p1_f - p0_f));
Lk_a = max(0, min(p1_a - xe_a, p1_a - p0_a));

%% Plot the planing surfaces for one h_RP and tau value.
_h_RP = h_RP;
_tau = 1*deg;

_Xwater = [-3 3];
_Ywater = [0 0];

_Xfloat= [ForeBody.*cos(_tau) + zk_f.*sin(_tau) AftBody.*cos(_tau) + zk_a.*sin(_tau)];
_Yfloat = [_h_RP + zk_f - ForeBody.*sin(_tau) _h_RP + zk_a - AftBody.*sin(_tau)];
plot(zeros(1,11), h_RP, 'x',
     _Xfloat, _Yfloat, 'r-',
     _Xwater, _Ywater, 'b-');
xlim(_Xwater);
ylim(_Xwater);
