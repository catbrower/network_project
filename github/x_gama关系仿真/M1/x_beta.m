clc
clear
% figure1 = figure('color',[1 1 1]);
% axes1 = axes('Parent',figure1,'XScale','log');%
% box(axes1,'on');
% hold(axes1,'on');
%≥ı ºªØ'FontSize',24,
total_number = 10;
%% 0.0
kgama_end = [];
dx_end = [];
xxx_end1 = []; xxx_end2 = [];
for num = 1 : total_number 
    filename1 = strcat('weight_da0',   num2str(num), '_change', '.mat');
    load (filename1);
    kgama1 = kgama;
    kgama_end = [kgama_end;kgama1];
    dx1 = dx(2,:);
    dx_end = [dx_end;dx1];
    xxx1 = xxx(1,:); xxx2 = xxx(2,:);
    xxx_end1 = [xxx_end1;xxx1]; 
    xxx_end2 = [xxx_end2;xxx2]; 
end
kgama = sum(kgama_end)./total_number;
dx = sum(dx_end)./total_number;
lg(1) = plot(kgama,dx,'.g');
xxx4(1,:) = sum(xxx_end1)./total_number;
xxx3(1,:) = sum(xxx_end2)./total_number;
xxx5 = [xxx3;xxx4];
xxx_find = find(xxx4-xxx3 < 0.0001);
xxx5(:,xxx_find(1:end-1)) = 0;
hold on
plot(kgama,xxx5,'-g');
hold on

%% 0.2
kgama_end = [];
dx_end = [];
xxx_end1 = []; xxx_end2 = [];
for num = 1 : total_number 
    filename1 = strcat('weight_da2',   num2str(num), '_change', '.mat');
    load (filename1);
    kgama1 = kgama;
    kgama_end = [kgama_end;kgama1];
    dx1 = dx(2,:);
    dx_end = [dx_end;dx1];
    xxx1 = xxx(1,:); xxx2 = xxx(2,:);
    xxx_end1 = [xxx_end1;xxx1]; 
    xxx_end2 = [xxx_end2;xxx2]; 
end
kgama = sum(kgama_end)./total_number;
dx = sum(dx_end)./total_number;
lg(2) = plot(kgama,dx,'.b');
xxx4(1,:) = sum(xxx_end1)./total_number;
xxx3(1,:) = sum(xxx_end2)./total_number;
xxx5 = [xxx3;xxx4];
xxx_find = find(xxx4-xxx3 < 0.0001);
xxx5(:,xxx_find(1:end-1)) = 0;
hold on
plot(kgama,xxx5,'-b');
hold on

%% 0.8
kgama_end = [];
dx_end = [];
xxx_end1 = []; xxx_end2 = [];
for num = 1 : total_number 
    filename1 = strcat('weight_da8',   num2str(num), '_change', '.mat');
    load (filename1);
    kgama1 = kgama;
    kgama_end = [kgama_end;kgama1];
    dx1 = dx(2,:);
    dx_end = [dx_end;dx1];
    xxx1 = xxx(1,:); xxx2 = xxx(2,:);
    xxx_end1 = [xxx_end1;xxx1]; 
    xxx_end2 = [xxx_end2;xxx2]; 
end
kgama = sum(kgama_end)./total_number;
dx = sum(dx_end)./total_number;
lg(3) = plot(kgama,dx,'.r');
xxx4(1,:) = sum(xxx_end1)./total_number;
xxx3(1,:) = sum(xxx_end2)./total_number;
xxx5 = [xxx3;xxx4];
xxx_find = find(xxx4-xxx3 < 0.0001);
xxx5(:,xxx_find(1:end-1)) = 0;
hold on
plot(kgama,xxx5,'-r');
hold on
%%
lgg=legend(lg([1,2,3]),{'°˜=0.0','°˜=0.2','°˜=0.8'},'FontName','Times New Roman','Location','East');
text(5,0.8,'d=0.05','FontSize',20,'FontName','Times New Roman');
axis([0.5 7.8 0 1]);
xlabel('K_{¶√}'), ylabel('<x>');

set(gca,'FontName','Times New Roman','FontSize',16);
