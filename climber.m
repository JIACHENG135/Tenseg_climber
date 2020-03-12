%% This is the connecting and animation generating function
% - Step 1
%   - generating N_top_cell for top dbar
%   - generating N_hub_cell for hub dbar
% - Step 2
%   - find the connecting index and aggregate them

% Step 1
q = 1;
comp = 3;
[N_top_cell,C_top_b,C_top_s,top_head,top_tail] = top_comp_animation(30,60,3,0,comp);
[N_hub_cell,C_hub_b,C_hub_s,hub_head,hub_tail] = three_d_dbar_animation(10,70,4,q,0);
save debug.mat
%%
whole_scale_vec = [-3 6 -40 30 -3 6];
% Step 2
comp = 3;
figure(1)
N3 = N_top_cell{1,length(N_top_cell)};
N4 = N_hub_cell{1,1};
N5 = N_top_cell{1,length(N_top_cell)};
% length(N_hub_cell)
for i=1:length(N_top_cell)
N1 = N_top_cell{1,length(N_top_cell)-i+1};
C_b_top_in =transferC_b2C_b_in(C_top_b);
C_s_top_in =transferC_b2C_b_in(C_top_s);
t_tail = top_tail(1);
t_head = top_head(1);
N2 = N_hub_cell{1,1};
h_head = hub_head(1);
h_tail = hub_tail(1);
C_b_hub_in =transferC_b2C_b_in(C_hub_b);
C_s_hub_in =transferC_b2C_b_in(C_hub_s);
[~,N2_t] = tenseg_rotate(N2(:,h_tail)'-N2(:,h_head)',N1(:,t_tail)'-N1(:,t_head)',N2);
[N_added,~,~,C_b_in_added,C_s_in_added]= trans_add_N(N1',N2_t',C_b_top_in,C_s_top_in,C_b_hub_in,C_s_hub_in,t_tail,h_head);

Pilot = dfs_search_index(C_b_in_added,3);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N5',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,Pilot,t_head);


new_h_tail = dfs_search_index(C_b_in_added,2*comp);
[~,N4_t] = tenseg_rotate(N4(:,h_tail)'-N4(:,h_head)',N1(:,t_tail)'-N1(:,t_head)',N4);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N4_t',C_b_in_added,C_s_in_added,C_b_hub_in,C_s_hub_in,new_h_tail,h_head);

Pilot = dfs_search_index(C_b_in_added,3);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N3',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,Pilot,t_head);

% [N_added,C_b_added,C_s_added] = trans_add_N(N_added,N3',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,new_h_tail,t_head);

tenseg_plot(N_added',C_b_added,C_s_added,1)
axis(whole_scale_vec)
hold on;
set(gcf,'Position',get(0,'ScreenSize'));
tenseg_savegif('top_animation_test_1');
hold off;
end


N3 = N_top_cell{1,length(N_top_cell)};
N5 = N_top_cell{1,length(N_top_cell)};
% length(N_hub_cell)
for i=1:length(N_hub_cell)
N1 = N_top_cell{1,1};
C_b_top_in =transferC_b2C_b_in(C_top_b);
C_s_top_in =transferC_b2C_b_in(C_top_s);
t_tail = top_tail(1);
t_head = top_head(1);
N2 = N_hub_cell{1,i};
N4 = N_hub_cell{1,i};
h_head = hub_head(1);
h_tail = hub_tail(1);
C_b_hub_in =transferC_b2C_b_in(C_hub_b);
C_s_hub_in =transferC_b2C_b_in(C_hub_s);
[~,N2_t] = tenseg_rotate(N2(:,h_tail)'-N2(:,h_head)',N1(:,t_tail)'-N1(:,t_head)',N2);
[N_added,~,~,C_b_in_added,C_s_in_added]= trans_add_N(N1',N2_t',C_b_top_in,C_s_top_in,C_b_hub_in,C_s_hub_in,t_tail,h_head);

Pilot = dfs_search_index(C_b_in_added,3);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N5',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,Pilot,t_head);


new_h_tail = dfs_search_index(C_b_in_added,2*comp);
[~,N4_t] = tenseg_rotate(N4(:,h_tail)'-N4(:,h_head)',N1(:,t_tail)'-N1(:,t_head)',N4);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N4_t',C_b_in_added,C_s_in_added,C_b_hub_in,C_s_hub_in,new_h_tail,h_head);

Pilot = dfs_search_index(C_b_in_added,3);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N3',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,Pilot,t_head);

% [N_added,C_b_added,C_s_added] = trans_add_N(N_added,N3',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,new_h_tail,t_head);

tenseg_plot(N_added',C_b_added,C_s_added,1)
axis(whole_scale_vec)
hold on;
set(gcf,'Position',get(0,'ScreenSize'));
tenseg_savegif('top_animation_test_1');
hold off;
end

N5 = N_top_cell{1,length(N_top_cell)};

% length(N_hub_cell)
for i=1:length(N_top_cell)
N1 = N_top_cell{1,1};
N3 = N_top_cell{1,length(N_top_cell)-i+1};
C_b_top_in =transferC_b2C_b_in(C_top_b);
C_s_top_in =transferC_b2C_b_in(C_top_s);
t_tail = top_tail(1);
t_head = top_head(1);
N2 = N_hub_cell{1,length(N_hub_cell)};
N4 = N_hub_cell{1,length(N_hub_cell)};
h_head = hub_head(1);
h_tail = hub_tail(1);
C_b_hub_in =transferC_b2C_b_in(C_hub_b);
C_s_hub_in =transferC_b2C_b_in(C_hub_s);
[~,N2_t] = tenseg_rotate(N2(:,h_tail)'-N2(:,h_head)',N1(:,t_tail)'-N1(:,t_head)',N2);
[N_added,~,~,C_b_in_added,C_s_in_added]= trans_add_N(N1',N2_t',C_b_top_in,C_s_top_in,C_b_hub_in,C_s_hub_in,t_tail,h_head);

Pilot = dfs_search_index(C_b_in_added,3);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N5',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,Pilot,t_head);


new_h_tail = dfs_search_index(C_b_in_added,2*comp);
[~,N4_t] = tenseg_rotate(N4(:,h_tail)'-N4(:,h_head)',N1(:,t_tail)'-N1(:,t_head)',N4);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N4_t',C_b_in_added,C_s_in_added,C_b_hub_in,C_s_hub_in,new_h_tail,h_head);

Pilot = dfs_search_index(C_b_in_added,3);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N3',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,Pilot,t_head);

% [N_added,C_b_added,C_s_added] = trans_add_N(N_added,N3',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,new_h_tail,t_head);

tenseg_plot(N_added',C_b_added,C_s_added,1)
axis(whole_scale_vec)
hold on;
set(gcf,'Position',get(0,'ScreenSize'));
tenseg_savegif('top_animation_test_1');
hold off;
end
N5 = N_top_cell{1,length(N_top_cell)};
N3 = N_top_cell{1,1};
trans_x = calc_translate(N_top_cell,t_tail);
% length(N_hub_cell)
for i=1:length(N_top_cell)
N1 = N_top_cell{1,i};
N1(2,:) = N1(2,:) + trans_x(i);
C_b_top_in =transferC_b2C_b_in(C_top_b);
C_s_top_in =transferC_b2C_b_in(C_top_s);
t_tail = top_tail(1);
t_head = top_head(1);
N2 = N_hub_cell{1,length(N_hub_cell)};
N4 = N_hub_cell{1,length(N_hub_cell)};
h_head = hub_head(1);
h_tail = hub_tail(1);
C_b_hub_in =transferC_b2C_b_in(C_hub_b);
C_s_hub_in =transferC_b2C_b_in(C_hub_s);
[~,N2_t] = tenseg_rotate(N2(:,h_tail)'-N2(:,h_head)',N1(:,t_tail)'-N1(:,t_head)',N2);
[N_added,~,~,C_b_in_added,C_s_in_added]= trans_add_N(N1',N2_t',C_b_top_in,C_s_top_in,C_b_hub_in,C_s_hub_in,t_tail,h_head);

Pilot = dfs_search_index(C_b_in_added,3);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N5',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,Pilot,t_head);


new_h_tail = dfs_search_index(C_b_in_added,2*comp);
[~,N4_t] = tenseg_rotate(N4(:,h_tail)'-N4(:,h_head)',N1(:,t_tail)'-N1(:,t_head)',N4);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N4_t',C_b_in_added,C_s_in_added,C_b_hub_in,C_s_hub_in,new_h_tail,h_head);

Pilot = dfs_search_index(C_b_in_added,3);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N3',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,Pilot,t_head);

% [N_added,C_b_added,C_s_added] = trans_add_N(N_added,N3',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,new_h_tail,t_head);

tenseg_plot(N_added',C_b_added,C_s_added,1)
axis(whole_scale_vec)
hold on;
set(gcf,'Position',get(0,'ScreenSize'));
tenseg_savegif('top_animation_test_1');
hold off;
end

N5 = N_top_cell{1,length(N_top_cell)};
N3 = N_top_cell{1,1};
rvs = 1;
trans_x = calc_translate(N_hub_cell,h_tail,rvs);
% length(N_hub_cell)
N1_ori = N1;
for i=1:length(N_hub_cell)
N1(2,:) = N1_ori(2,:) + 2*trans_x(i);
C_b_top_in =transferC_b2C_b_in(C_top_b);
C_s_top_in =transferC_b2C_b_in(C_top_s);
t_tail = top_tail(1);
t_head = top_head(1);
N2 = N_hub_cell{1,length(N_hub_cell)-i+1};
N4 = N_hub_cell{1,length(N_hub_cell)-i+1};
h_head = hub_head(1);
h_tail = hub_tail(1);
C_b_hub_in =transferC_b2C_b_in(C_hub_b);
C_s_hub_in =transferC_b2C_b_in(C_hub_s);
[~,N2_t] = tenseg_rotate(N2(:,h_tail)'-N2(:,h_head)',N1(:,t_tail)'-N1(:,t_head)',N2);
[N_added,~,~,C_b_in_added,C_s_in_added]= trans_add_N(N1',N2_t',C_b_top_in,C_s_top_in,C_b_hub_in,C_s_hub_in,t_tail,h_head);

Pilot = dfs_search_index(C_b_in_added,3);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N5',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,Pilot,t_head);


new_h_tail = dfs_search_index(C_b_in_added,2*comp);
[~,N4_t] = tenseg_rotate(N4(:,h_tail)'-N4(:,h_head)',N1(:,t_tail)'-N1(:,t_head)',N4);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N4_t',C_b_in_added,C_s_in_added,C_b_hub_in,C_s_hub_in,new_h_tail,h_head);

Pilot = dfs_search_index(C_b_in_added,3);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N3',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,Pilot,t_head);

% [N_added,C_b_added,C_s_added] = trans_add_N(N_added,N3',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,new_h_tail,t_head);

tenseg_plot(N_added',C_b_added,C_s_added,1)
axis(whole_scale_vec)
hold on;
set(gcf,'Position',get(0,'ScreenSize'));
tenseg_savegif('top_animation_test_1');
hold off;
end

N5 = N_top_cell{1,length(N_top_cell)};
N3 = N_top_cell{1,1};
reverse = 1;
trans_x = calc_translate(N_top_cell,t_tail,reverse,N1);% length(N_hub_cell)
N1_ori = N1;
for i=1:length(N_top_cell)
N1 = N_top_cell{1,length(N_top_cell) - i+1};
N1(2,:) = N1(2,:) + trans_x(i);
C_b_top_in =transferC_b2C_b_in(C_top_b);
C_s_top_in =transferC_b2C_b_in(C_top_s);
t_tail = top_tail(1);
t_head = top_head(1);
N2 = N_hub_cell{1,1};
N4 = N_hub_cell{1,1};
h_head = hub_head(1);
h_tail = hub_tail(1);
C_b_hub_in =transferC_b2C_b_in(C_hub_b);
C_s_hub_in =transferC_b2C_b_in(C_hub_s);
[~,N2_t] = tenseg_rotate(N2(:,h_tail)'-N2(:,h_head)',N1(:,t_tail)'-N1(:,t_head)',N2);
[N_added,~,~,C_b_in_added,C_s_in_added]= trans_add_N(N1',N2_t',C_b_top_in,C_s_top_in,C_b_hub_in,C_s_hub_in,t_tail,h_head);

Pilot = dfs_search_index(C_b_in_added,3);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N5',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,Pilot,t_head);


new_h_tail = dfs_search_index(C_b_in_added,2*comp);
[~,N4_t] = tenseg_rotate(N4(:,h_tail)'-N4(:,h_head)',N1(:,t_tail)'-N1(:,t_head)',N4);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N4_t',C_b_in_added,C_s_in_added,C_b_hub_in,C_s_hub_in,new_h_tail,h_head);

Pilot = dfs_search_index(C_b_in_added,3);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N3',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,Pilot,t_head);

% [N_added,C_b_added,C_s_added] = trans_add_N(N_added,N3',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,new_h_tail,t_head);

tenseg_plot(N_added',C_b_added,C_s_added,1)
axis(whole_scale_vec)
hold on;
set(gcf,'Position',get(0,'ScreenSize'));
tenseg_savegif('top_animation_test_1');
hold off;
end

N5 = N_top_cell{1,length(N_top_cell)};
reverse = 1;
trans_x = calc_translate(N_top_cell,t_tail,reverse,N1);% length(N_hub_cell)

for i=1:length(N_top_cell)
N3 = N_top_cell{1,i};
C_b_top_in =transferC_b2C_b_in(C_top_b);
C_s_top_in =transferC_b2C_b_in(C_top_s);
t_tail = top_tail(1);
t_head = top_head(1);
N2 = N_hub_cell{1,1};
N4 = N_hub_cell{1,1};
h_head = hub_head(1);
h_tail = hub_tail(1);
C_b_hub_in =transferC_b2C_b_in(C_hub_b);
C_s_hub_in =transferC_b2C_b_in(C_hub_s);
[~,N2_t] = tenseg_rotate(N2(:,h_tail)'-N2(:,h_head)',N1(:,t_tail)'-N1(:,t_head)',N2);
[N_added,~,~,C_b_in_added,C_s_in_added]= trans_add_N(N1',N2_t',C_b_top_in,C_s_top_in,C_b_hub_in,C_s_hub_in,t_tail,h_head);

Pilot = dfs_search_index(C_b_in_added,3);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N5',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,Pilot,t_head);


new_h_tail = dfs_search_index(C_b_in_added,2*comp);
[~,N4_t] = tenseg_rotate(N4(:,h_tail)'-N4(:,h_head)',N1(:,t_tail)'-N1(:,t_head)',N4);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N4_t',C_b_in_added,C_s_in_added,C_b_hub_in,C_s_hub_in,new_h_tail,h_head);

Pilot = dfs_search_index(C_b_in_added,3);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N3',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,Pilot,t_head);

% [N_added,C_b_added,C_s_added] = trans_add_N(N_added,N3',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,new_h_tail,t_head);

tenseg_plot(N_added',C_b_added,C_s_added,1)
axis(whole_scale_vec)
hold on;
set(gcf,'Position',get(0,'ScreenSize'));
tenseg_savegif('top_animation_test_1');
hold off;
end

N5 = N_top_cell{1,length(N_top_cell)};
reverse = 1;
trans_x = calc_translate(N_top_cell,t_tail,reverse,N1);% length(N_hub_cell)

for i=1:length(N_hub_cell)
N3 = N_top_cell{1,length(N_top_cell)};
C_b_top_in =transferC_b2C_b_in(C_top_b);
C_s_top_in =transferC_b2C_b_in(C_top_s);
t_tail = top_tail(1);
t_head = top_head(1);
N2 = N_hub_cell{1,i};
N4 = N_hub_cell{1,i};
h_head = hub_head(1);
h_tail = hub_tail(1);
C_b_hub_in =transferC_b2C_b_in(C_hub_b);
C_s_hub_in =transferC_b2C_b_in(C_hub_s);
[~,N2_t] = tenseg_rotate(N2(:,h_tail)'-N2(:,h_head)',N1(:,t_tail)'-N1(:,t_head)',N2);
[N_added,~,~,C_b_in_added,C_s_in_added]= trans_add_N(N1',N2_t',C_b_top_in,C_s_top_in,C_b_hub_in,C_s_hub_in,t_tail,h_head);

Pilot = dfs_search_index(C_b_in_added,3);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N5',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,Pilot,t_head);


new_h_tail = dfs_search_index(C_b_in_added,2*comp);
[~,N4_t] = tenseg_rotate(N4(:,h_tail)'-N4(:,h_head)',N1(:,t_tail)'-N1(:,t_head)',N4);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N4_t',C_b_in_added,C_s_in_added,C_b_hub_in,C_s_hub_in,new_h_tail,h_head);

Pilot = dfs_search_index(C_b_in_added,3);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N3',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,Pilot,t_head);

% [N_added,C_b_added,C_s_added] = trans_add_N(N_added,N3',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,new_h_tail,t_head);

tenseg_plot(N_added',C_b_added,C_s_added,1)
axis(whole_scale_vec)
hold on;
set(gcf,'Position',get(0,'ScreenSize'));
tenseg_savegif('top_animation_test_1');
hold off;
end
N = N_added;
C_b = C_b_added;
C_s = C_s_added;
save('final_state.mat','N','C_b','C_s')