function N = tenseg_animation_helper(dyn,inheret,reverse,base_cell,translate_dir)
if length(inheret)~=1
   N = inheret;
else
    if dyn == 0
        if reverse
            N = base_cell{1,length(base_cell)};
        else
            N = base_cell{1,1};
        end
    else
        if reverse 
            N = base_cell{1,length(base_cell)-dyn+1};
        else
            N = base_cell{1,dyn};
        end
    end

end






end