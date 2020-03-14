function [N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = tenseg_combiner(N1,N2,N3,N4,N5,C_b_top_in,C_s_top_in,C_b_hub_in,C_s_hub_in,t_tail,t_head,h_tail,h_head,comp)

[~,N2_t] = tenseg_rotate(N2(:,h_tail)'-N2(:,h_head)',N1(:,t_tail)'-N1(:,t_head)',N2);
[N_added,~,~,C_b_in_added,C_s_in_added]= trans_add_N(N1',N2_t',C_b_top_in,C_s_top_in,C_b_hub_in,C_s_hub_in,t_tail,h_head);

Pilot = dfs_search_index(C_b_in_added,3);
[N_added,~,~,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N5',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,Pilot,t_head);

Pilot = dfs_search_index(C_b_in_added,2*comp);
[~,N4_t] = tenseg_rotate(N4(:,h_tail)'-N4(:,h_head)',N1(:,t_tail)'-N1(:,t_head)',N4);
[N_added,~,~,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N4_t',C_b_in_added,C_s_in_added,C_b_hub_in,C_s_hub_in,Pilot,h_head);

Pilot = dfs_search_index(C_b_in_added,3);
[N_added,C_b_added,C_s_added,C_b_in_added,C_s_in_added] = trans_add_N(N_added,N3',C_b_in_added,C_s_in_added,C_b_top_in,C_s_top_in,Pilot,t_head);

end