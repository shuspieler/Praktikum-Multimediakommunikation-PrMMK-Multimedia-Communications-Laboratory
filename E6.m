%%
%E6-6
[rate, psnr, enc_time, dec_time] = get_dr_result_intra('encoder_basic_intra', 'decoder_basic_intra', 'flowergarden_short_cif.yuv', [6,8,10,15,20], 8);
%%
%E6-11
[rate, psnr, enc_time, dec_time] = get_dr_result('encoder_basic','decoder_basic', 'flowergarden_short_cif.yuv',[6,8,10,15,20],8,8,8);
%%
%E6-12
[rate1, psnr1, enc_time1, dec_time1] = get_dr_result('encoder_basic','decoder_basic', 'vimto_short_cif.yuv',[6,8,10,15,20],8,8,8);
[rate2, psnr2, enc_time2, dec_time2] = get_dr_result('encoder_basic','decoder_basic', 'rugby_short_cif.yuv',[6,8,10,15,20],8,8,8);
[rate3, psnr3, enc_time3, dec_time3] = get_dr_result('encoder_basic','decoder_basic', 'shuttle_short_cif.yuv',[6,8,10,15,20],8,8,8);
%%
%E6-13
[rate1, psnr1, enc_time1, dec_time1] = get_dr_result('encoder_basic','decoder_basic', 'vimto_short_cif.yuv',35,8,8,8);
[rate2, psnr2, enc_time2, dec_time2] = get_dr_result('encoder_basic','decoder_basic', 'vimto_short_cif.yuv',35,8,8,16);
%%
%E6-14
[rate1, psnr1, enc_time1, dec_time1] = get_dr_result('encoder_basic','decoder_basic', 'vimto_short_cif.yuv',35,8,4,8);
[rate2, psnr2, enc_time2, dec_time2] = get_dr_result('encoder_basic','decoder_basic', 'vimto_short_cif.yuv',35,8,8,8);
[rate3, psnr3, enc_time3, dec_time3] = get_dr_result('encoder_basic','decoder_basic', 'vimto_short_cif.yuv',35,8,16,8);
%%
%E6-15
tic;
final_encoder('rugby_short_cif.yuv','rugby_q12.mat',352,288,5,8);
toc
%%
%E6-17
get_final_result('rugby_short_cif.yuv');
get_final_result('vimto_short_cif.yuv');
get_final_result('shuttle_short_cif.yuv');

