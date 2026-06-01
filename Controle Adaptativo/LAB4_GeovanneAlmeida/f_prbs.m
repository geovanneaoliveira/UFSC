
function x = f_prbs(order, N, seed)

  x = zeros(1,N);
  a = uint32(seed);

  if (order == 7)
    d1 = 7;
    d2 = 6;
  elseif (order == 9)
    d1 = 9;
    d2 = 5
  elseif (order == 11)
    d1 = 11;
    d2 = 9;
  elseif (order == 13)
    d1 = 13;
    d2 = 12;
    d3 = 2;
    d4 = 1;
  elseif (order == 15)
    d1 = 15;
    d2 = 14;
  elseif (order == 20)
    d1 = 20;
    d2 = 3;
  elseif (order == 23)
    d1 = 23;
    d2 = 18;
  elseif (order == 31)
    d1 = 31;
    d2 = 28;
  else
    x = -1;
    return;
  end

  mask = 2^order - 1;

  for k = 1:N
    if order == 13
      a1 = bitxor(bitshift(a,-(d1-1)), bitshift(a,-(d2-1)));
      a2 = bitxor(a1, bitshift(a, -(d3-1)));
      a3 = bitxor(a2, bitshift(a, -(d4-1)));
      newbit = bitand(a3, 1);
    else
      newbit = bitand(bitxor(bitshift(a,-(d1-1)), bitshift(a,-(d2-1))),1);
    end

    a = uint32(bitand(bitor(bitshift(a,1), newbit), mask));

    x(k) = bitand(bitshift(a,-(order-1)), 1);
  end

end

