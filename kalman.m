function kalman()
    global button_pressed;
  
    button_pressed = false;
    figure;    
    axis([-5, 5, -5, 5]);
    hold on;
    set(gcf, 'WindowButtonMotionFcn', @ButtonMotionFcn);
    set(gcf, 'WindowButtonDownFcn', @ButtonDownFcn); 
    set(gcf, 'WindowButtonUpFcn', @ButtonUpFcn);
end

function ButtonMotionFcn(src, event)
    global button_pressed;
    global Sp; 
    global Cp;
    global Sa;
    global Q;
    global R;
    global F;
    global H;
    if (button_pressed)

        S = F * Sp;
        
        pt = get(gca, 'CurrentPoint');        

        Xmp = H * Sa + rand(2, 1) - 0.5;
        Sa(1, 1) = pt(1, 1);
        Sa(2, 1) = pt(1, 2);

        K = Cp * H' * (H * Cp * H' + R)^-1;

        Sk = S + K * (Xmp - H * S);

        Cp = (diag(ones(4,1), 0) - K * H) * Cp;
        Cp = F * Cp * F' + Q;
        Sp = Sk;
        
        plot(Sa(1, 1), Sa(2, 1),'r.', Sk(1,1), Sk(2, 1), 'g.', Xmp(1, 1), Xmp(2, 1), 'b*');
    end
end

function ButtonDownFcn(src, event)
    global button_pressed;
    global Q;
    global R;
    global Sp;
    global Sa;
    global F;
    global H;
    global Cp;
    
    Cp = zeros(4, 4);
    Sp = zeros(4, 1);
    F = zeros(4, 4);
    Q = diag(ones(4,1), 0);
    R = 10000*diag(ones(2,1), 0);
    
    pt = get(gca, 'CurrentPoint');
    Sp(1, 1) = pt(1, 1);
    Sp(2, 1) = pt(1, 2);

    Sa = Sp;
    
    F = [1 0 1 0; 0 1 0 1; 0 0 1 0; 0 0 0 1];
    H = [1 0 0 0; 0 1 0 0];
    button_pressed = true;
end

function ButtonUpFcn(src, event)
    global button_pressed;
    button_pressed = false;
end