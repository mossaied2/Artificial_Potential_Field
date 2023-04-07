function d = bwdist_1D (map)
    obstacles_locations = [];
    d = [];
    
    % find obstacles
    for i = 1 : numel(map)
        if(map(i) == 1)
            obstacles_locations = [obstacles_locations i]
        end
    end
    
    % calculating distance to obstacle
    for i = 1 : numel(map) % i represent the x-coordinate 
        distances_to_obstacles = [];
        for j = 1 : numel(obstacles_locations)
            distances_to_obstacles = [distances_to_obstacles abs(i-obstacles_locations(j))];
        end
        
        d = [d min(distances_to_obstacles)];
    end
    
end

