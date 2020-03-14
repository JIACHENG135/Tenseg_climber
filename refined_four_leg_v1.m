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
C_b_top_in =transferC_b2C_b_in(C_top_b);
C_s_top_in =transferC_b2C_b_in(C_top_s);

t_tail = top_tail(1);
t_head = top_head(1);
h_head = hub_head(1);
h_tail = hub_tail(1);
C_b_hub_in =transferC_b2C_b_in(C_hub_b);
C_s_hub_in =transferC_b2C_b_in(C_hub_s);

whole_scale_vec = [-3 6 -40 30 -3 6];
% Step 2
comp = 3;
frame1 = length(N_top_cell);
frame2 = length(N_hub_cell);

figure(1)
% length(N_hub_cell)
% dyn,inheret,reverse,translate_dir
animation_state_1 = [[1,0,1,2];[0,0,0,2];[0,0,0,2];[1,0,0,2];[0,1,0,2]];
animation_state_2 = [[0,0,0,2];[1,0,0,2];[0,0,1,2];[0,0,1,2];[1,0,1,2]];
animation_state_3 = [[0,0,1,2];[0,0,1,2];[1,0,1,2];[0,0,0,2];[0,0,0,2]];
animation_state_4 = [[0,0,0,2];[1,0,0,2];[0,0,1,2];[0,0,1,2];[1,0,1,2]];
animation_state_5 = [[0,0,1,2];[0,0,1,2];[0,0,1,2];[0,0,1,2];[0,0,1,2]];

% animation_state = [animation_state_1;animation_state_2;animation_state_]

translate_matrix = zeros(5,length(N_top_cell{1,1}));
translate_cell = cell(1,10);
translate_base = zeros(1,10);
translate_base(5) = 1;
translate_cell{1,4} = calc_translate(N_top_cell,t_tail);
translate_cell{1,5} = 2*calc_translate(N_hub_cell,h_tail,1);
for_frame = [frame1,frame2,frame1,frame1,frame2];
figure(1)
for loop=1:length(animation_state_1(:,1))
    N1_state = animation_state_1(loop,:);
    N2_state = animation_state_2(loop,:);
    N3_state = animation_state_3(loop,:);
    N4_state = animation_state_4(loop,:);
    N5_state = animation_state_5(loop,:);
    for j=1:for_frame(loop)
        dyn1 = N1_state(1);
        dyn2 = N2_state(1);
        dyn3 = N3_state(1);
        dyn4 = N4_state(1);
        dyn5 = N5_state(1);
        if dyn1~=0
            dyn1=j;
        end
        if dyn2~=0
            dyn2=j;
        end
        if dyn3~=0
            dyn3=j;
        end
        if dyn4~=0
            dyn4=j;
        end
        if dyn5~=0
            dyn5=j;
        end
        inheret1 = N1_state(2);
        inheret2 = N2_state(2);
        inheret3 = N3_state(2);
        inheret4 = N4_state(2);
        inheret5 = N5_state(2);
        reverse1 = N1_state(3);
        reverse2 = N2_state(3);
        reverse3 = N3_state(3);
        reverse4 = N4_state(3);
        reverse5 = N5_state(3);
        translate_dir1 = N1_state(4);        
        translate_dir2 = N2_state(4);
        translate_dir3 = N3_state(4);
        translate_dir4 = N4_state(4);
        translate_dir5 = N5_state(4);
        translate = translate_cell{1,loop};
        if inheret1==0
            N1 = tenseg_animation_helper(dyn1,inheret1,reverse1,N_top_cell,translate_dir1);
        end
        if length(translate)~=0
            if translate_base(loop)==0
                N1(translate_dir1,:)  = N1(translate_dir1,:) + translate(j);
            else
                N1(translate_dir1,:)  = N_ori(translate_dir1,:) + translate(j);
            end
        end
        N2 = tenseg_animation_helper(dyn2,inheret2,reverse2,N_hub_cell,translate_dir2);
        N3 = tenseg_animation_helper(dyn3,inheret3,reverse3,N_top_cell,translate_dir3);
        N4 = tenseg_animation_helper(dyn4,inheret4,reverse4,N_hub_cell,translate_dir4);
        N5 = tenseg_animation_helper(dyn5,inheret5,reverse5,N_top_cell,translate_dir5);
        save test_debug.mat
        [N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = tenseg_combiner(N1,N2,N3,N4,N5,C_b_top_in,C_s_top_in,C_b_hub_in,C_s_hub_in,t_tail,t_head,h_tail,h_head,comp);
        tenseg_plot(N_added',C_b_added,C_s_added,1)
        axis(whole_scale_vec)
        hold on;
        set(gcf,'Position',get(0,'ScreenSize'));
        tenseg_savegif('top_animation_test_1');
        hold off;
    end
    N_ori = N1;
    
end