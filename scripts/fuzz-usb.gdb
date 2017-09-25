set pagination off
break blk_aio_preadv

commands
if offset>1024
    set usb_fuzz = 1
else
    set usb_fuzz = 0
end

cont
end
