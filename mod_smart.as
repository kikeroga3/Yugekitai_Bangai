;-----------------------------------------------------
; 
; HSP3�p�X�}�[�g�t�H�����W���[���umod_smart.as�v
;
; Ver 3.1 (�����ӁFVer 3.0�ȍ~����uhsp3dish.as�v���K�{�ƂȂ�܂����B���O�Ɂuhsp3dish.as�v���C���N���[�h���Ă�������)
;
; By. ���܂���˂�
;
; http://www.geocities.jp/simakuroneko646/
;
; simakuroneko@gmail.com
;
;-----------------------------------------------------

#module mod_smart

#const SARCH_TIME_MAX 				863999999	;23��59��59�b�̃~���b
#const DEFAULT_TAP_INTERVAL 		400			;smart_tap���߂̃^�b�v��F�����鎞��(���̎��Ԉȓ��Ɏw�������āA�w�𗣂�)
#const DEFAULT_TOUCH_INTERVAL 		1000		;smart_touch���߂̃^�b�`��F�����鎞��(���̎��Ԉȏ�w������������)
#const DEFAULT_DRAG_INTERVAL        1000		;smart_drag���߂̃h���b�O��F�����鎞��(���̎��Ԉȏ�w������������)
#const DEFAULT_DOUBLE_TAP_INTERVAL 	700			;smart_dtap���߂̃_�u���^�b�v��F�����鎞��(���̎��Ԉȓ���1��ڂ̃^�b�v����2��ڂ̃^�b�v���s�Ȃ�)
#const DEFAULT_SWIPE_INTERVAL 		600			;smart_vswipe/smart_hswipe���߂̃X���C�v��F�����鎞��(���̎��Ԉȓ��Ɏw�������āA�w�𗣂�)
#const POINT_SPLIT					8			;smart_vswipe/smart_hswipe���ߓ��Ŏg�p���Ă���X���C�v�ʂ�10����
#const PARAM_1						0
#const PARAM_2						1


;-----------------------------------------------------
; smart_init
;
; ���W���[���̏�������
;-----------------------------------------------------
#deffunc smart_init

	;smart_one�p
	one_click_left  = 0
	one_click_right = 0

	;(����)
	;smrat_tap(�^�b�v)
	;smart_touch(�^�b�`)
	;smart_dtap(�_�u���^�b�v)
	;smart_drag(�h���b�O)
	;smart_vswipe,smart_hswipe((�X���C�v)�p
	dim tv,    1, 2, 4
	dim cp,    1, 4
	dim moux,  1, 4
	dim mouy,  1, 4
	dim add_m, 1

	return


;-----------------------------------------------------
; smart_mousearea
;
; �w��̗̈���Ƀ}�E�X�J�[�\�������邩�擾
;
; x1 : ����X���W
; y1 : ����Y���W
; x2 : �E��X���W
; y2 : �E��Y���W
;
; �߂�l(0 = �w��̗̈���Ƀ}�E�X�J�[�\�����Ȃ�)
;       (1 = �w��̗̈���Ƀ}�E�X�J�[�\��������)
;
;=====================================================
; SAMPLE
;	if smart_mousearea(0, 0, 100, 200) = 1 : dialog "OK"
;-----------------------------------------------------
#defcfunc smart_mousearea int x1, int y1, int x2, int y2

	re = 0
	
	if mousex >= x1 {
		if mousex <= x2 {
			if mousey >= y1 {
				if mousey <= y2 {
					re = 1
				}
			}
		}
	}
	
	return re


;-----------------------------------------------------
; smart_add
;
; �^�b�v���̑�����擾���邽�߂̃A�N�V������ǉ����܂��B
;
;
; add_mode           : �ǉ�����A�N�V�������[�h(���Ⴆ�΁A0=�^�b�v, 1=�^�b�`, 2=�h���b�O, 3=�_�u���^�b�v, 4=�c�X���C�v, 5=���X���C�v�@�Ȃ�)
;                      (��smart_get�֐��Ŏw�肵���A�N�V�����ԍ����ǂ̑���̂��̂��𒲂ׂ�̂ɗ��p���Ă�������)
;                      (���A�N�V�������[�h�͏ȗ��\�ł�)
;
; ���ߏI����A�V�X�e���ϐ�(stat)�ɃA�N�V�����ԍ�������܂��B
;
;=====================================================
; SAMPLE
;
;	smart_add 1 : act_number = stat
;
;-----------------------------------------------------
#deffunc smart_add int add_mode

	;----------------- tv
	d1 = length(tv)
	d2 = length2(tv)
	d3 = length3(tv)
	
	dim d_tv, d1, d2, d3
	
	repeat d1
		cnt_d1 = cnt
		repeat d2
			cnt_d2 = cnt
			repeat d3
				cnt_d3 = cnt 
				d_tv(cnt_d1, cnt_d2, cnt_d3) = tv(cnt_d1, cnt_d2, cnt_d3)
			loop
		loop
	loop

	dim tv, d1 + 1, d2, d3

	repeat d1
		cnt_d1 = cnt
		repeat d2
			cnt_d2 = cnt
			repeat d3
				cnt_d3 = cnt 
				tv(cnt_d1, cnt_d2, cnt_d3) = d_tv(cnt_d1, cnt_d2, cnt_d3)
			loop
		loop
	loop

	dim d_tv, 1, 1, 1

	;----------------- cp
	d1 = length(cp)
	d2 = length2(cp)
	
	dim d_cp, d1, d2
	
	repeat d1
		cnt_d1 = cnt
		repeat d2
			cnt_d2 = cnt
			d_cp(cnt_d1, cnt_d2) = cp(cnt_d1, cnt_d2)
		loop
	loop

	dim cp, d1 + 1, d2

	repeat d1
		cnt_d1 = cnt
		repeat d2
			cnt_d2 = cnt
			cp(cnt_d1, cnt_d2) = d_cp(cnt_d1, cnt_d2)
		loop
	loop

	dim d_cp, 1, 1

	;----------------- moux
	d1 = length(moux)
	d2 = length2(moux)
	
	dim d_moux, d1, d2
	
	repeat d1
		cnt_d1 = cnt
		repeat d2
			cnt_d2 = cnt
			d_moux(cnt_d1, cnt_d2) = moux(cnt_d1, cnt_d2)
		loop
	loop

	dim moux, d1 + 1, d2

	repeat d1
		cnt_d1 = cnt
		repeat d2
			cnt_d2 = cnt
			moux(cnt_d1, cnt_d2) = d_moux(cnt_d1, cnt_d2)
		loop
	loop

	dim d_moux, 1, 1

	;----------------- mouy
	d1 = length(mouy)
	d2 = length2(mouy)
	
	dim d_mouy, d1, d2
	
	repeat d1
		cnt_d1 = cnt
		repeat d2
			cnt_d2 = cnt
			d_mouy(cnt_d1, cnt_d2) = mouy(cnt_d1, cnt_d2)
		loop
	loop

	dim mouy, d1 + 1, d2

	repeat d1
		cnt_d1 = cnt
		repeat d2
			cnt_d2 = cnt
			mouy(cnt_d1, cnt_d2) = d_mouy(cnt_d1, cnt_d2)
		loop
	loop

	dim d_mouy, 1, 1

	;----------------- add_m
	d1 = length(add_m)
	
	dim d_add_m, d1
	
	repeat d1
		cnt_d1 = cnt
		d_add_m(cnt_d1) = add_m(cnt_d1)
	loop

	dim add_m, d1 + 1

	repeat d1
		cnt_d1 = cnt
		add_m(cnt_d1) = d_add_m(cnt_d1)
	loop
	
	re = d1 - 1	
	
	add_m(re) = add_mode

	dim d_add_m, 1

	return re


;-----------------------------------------------------
; smart_mode_get
;
; �w��̃A�N�V�����ԍ�����A�N�V�������[�h���擾���܂��B
;
;
; act_num           : �A�N�V�������[�h���擾�������A�N�V�����ԍ�
;
;
; �߂�l
;   0 �` = �A�N�V�������[�h
;
;
;=====================================================
; SAMPLE
;
;   smart_add, 1
;   action_number = stat
;	action_mode = smart_mode_get(action_number)
;
;   title "" + action_mode
;
;-----------------------------------------------------
#defcfunc smart_mode_get int act_num

	d1 = length(add_m) - 1

	if act_num >= d1 {
		re = -1
	} else {
		re = add_m(act_num)
	}

	return re


;-----------------------------------------------------
; smart_tap
;
; �^�b�v���擾
;
;
; act_num           : �A�N�V�������擾����A�N�V�����ԍ�
; x1, y1, x2, y2    : �^�b�v��F�������ʍ��W
; tap_interval      : �w��̎��Ԃ̊Ԃɉ�ʂ��w�ŉ����ė����܂ł��^�b�v�ƔF������(�P�ʁF�~���b)�B�ȗ����́A400�~���b�Ƃ���B
;
;
; �߂�l
;   0 = �^�b�v����Ă��Ȃ�
;   1 = �^�b�v����n�߂�(��ʂɎw������ꂽ)
;   2 = �^�b�v���I�����(��ʂ���w�𗣂��ꂽ)
;
;
;=====================================================
; SAMPLE
;
;   smart_add
;	if smart_tap(smart, 0, 0, 319, 479, 400) = 2 : mes "TAP OK"
;
;-----------------------------------------------------
#defcfunc smart_tap int act_num, int x1, int y1, int x2, int y2, int tap_interval

	t_interval = tap_interval
	if t_interval = 0 : t_interval = DEFAULT_TAP_INTERVAL
	dim touch_id, 1 : mtlist touch_id : tap_key = stat

	if tap_key > 0 {
		i      = cp(act_num, PARAM_1)
		hour   = gettime(4) * 1000 * 60 * 60
		minute = gettime(5) * 1000 * 60
		second = gettime(6) * 1000
		tv(act_num, PARAM_1, i) = hour + minute + second + gettime(7)
		moux(act_num, i) = mousex
		mouy(act_num, i) = mousey
		
		if i = 0 {
			cp(act_num, PARAM_1) = 1
			re = 0
			if moux(act_num, 0) >= x1 {
				if moux(act_num, 0) <= x2 {
					if mouy(act_num, 0) >= y1 {
						if mouy(act_num, 0) <= y2 {
							re = 1
						}
					}
				}
			}
			if re = 0 {
				return 0
			} else {
				return 1
			}
		}
		
		if i = 1 {
			re = 0
			if moux(act_num, 0) >= x1 {
				if moux(act_num, 0) <= x2 {
					if mouy(act_num, 0) >= y1 {
						if mouy(act_num, 0) <= y2 {
							re = 1
						}
					}
				}
			}
			if re = 0 : return 0

			re = 0
			if moux(act_num, 1) >= x1 {
				if moux(act_num, 1) <= x2 {
					if mouy(act_num, 1) >= y1 {
						if mouy(act_num, 1) <= y2 {
							re = 1
						}
					}
				}
			}
			if re = 0 : return 0
			
			if tv(act_num, PARAM_1, 0) > tv(act_num, PARAM_1, 1) : tv(act_num, PARAM_1, 0) = SARCH_TIME_MAX - tv(act_num, PARAM_1, 0) + tv(act_num, PARAM_1, 1)
			t = tv(act_num, PARAM_1, 1) - tv(act_num, PARAM_1, 0)
			if (t > t_interval) & (t_interval ! -1) {
				return 0
			} else {
				return 1
			}
		}
	}

	if tap_key = 0 {
		i  = cp(act_num, PARAM_1)
		if i = 1 {
			hour   = gettime(4) * 1000 * 60 * 60
			minute = gettime(5) * 1000 * 60
			second = gettime(6) * 1000
			tv(act_num, PARAM_1, i) = hour + minute + second + gettime(7)
			moux(act_num, i) = mousex
			mouy(act_num, i) = mousey
			if tv(act_num, PARAM_1, 0) > tv(act_num, PARAM_1, 1) : tv(act_num, PARAM_1, 0) = SARCH_TIME_MAX - tv(act_num, PARAM_1, 0) + tv(act_num, PARAM_1, 1)
			t = tv(act_num, PARAM_1, 1) - tv(act_num, PARAM_1, 0)

			if (t <= t_interval) | (t_interval = -1) {
				
				cp(act_num, PARAM_1) = 2
	
				re = 0
				if (moux(act_num, 0) >= x1) {
					if (moux(act_num, 0) <= x2) {
						if (mouy(act_num, 0) >= y1) {
							if (mouy(act_num, 0) <= y2) {
								re = 1
							}
						}
					}
				}
				if re = 0 : return 0
	
				re = 0
				if (moux(act_num, 1) >= x1) {
					if (moux(act_num, 1) <= x2) {
						if (mouy(act_num, 1) >= y1) {
							if (mouy(act_num, 1) <= y2) {
								re = 1
							}
						}
					}
				}
				if re = 0 {
					return 0
				} else {
					return 2
				}
			}
		}
	}
	
	tv(act_num, PARAM_1, 0) = 0
	tv(act_num, PARAM_1, 1) = 0
	tv(act_num, PARAM_1, 2) = 0
	tv(act_num, PARAM_1, 3) = 0
	cp(act_num, PARAM_1) = 0

	return 0
	

;-----------------------------------------------------
; smart_touch
;
; �^�b�`(������)���擾  (���^�b�`���F�����ꂽ��A���̂܂܎w��������Ă��Ă��^�b�`�ƔF������܂���B)
;
;
; act_num           : �A�N�V�������擾����A�N�V�����ԍ�
; x1, y1, x2, y2    : �^�b�`��F�������ʍ��W
; touch_interval    : �^�b�`�ƔF������܂ł̎���(�P�ʁF�~���b)�B�ȗ����́A1000�~���b�Ƃ���B
;
;
; �߂�l
;   0 = �^�b�`(������)����Ă��Ȃ�
;   1 = �^�b�`(������)���ꂽ(��ʂɎw����������ꂽ)
;   2 = �^�b�`(������)���I�����(��ʂ���w�𗣂��ꂽ)
;
;
;=====================================================
; SAMPLE
;
;   smart_add
;	if smart_touch(stat, 0, 0, 319, 479, 1000) = 1 : mes "TOUCH OK"
;
;-----------------------------------------------------
#defcfunc smart_touch int act_num, int x1, int y1, int x2, int y2, int touch_interval

	t_interval = touch_interval
	if t_interval = 0 : t_interval = DEFAULT_TOUCH_INTERVAL
	dim touch_id, 1 : mtlist touch_id : touch_key = stat

	if touch_key > 0 {
		if cp(act_num, PARAM_1) = 2 : return 0
		i      = cp(act_num, PARAM_1)
		hour   = gettime(4) * 1000 * 60 * 60
		minute = gettime(5) * 1000 * 60
		second = gettime(6) * 1000
		tv(act_num, PARAM_1, i) = hour + minute + second + gettime(7)
		moux(act_num, i) = mousex
		mouy(act_num, i) = mousey

		if i = 0 {
			cp(act_num, PARAM_1) = 1
			return 0
		}
		
		if i = 1 {

			re = 0
			if moux(act_num, 0) >= x1 {
				if moux(act_num, 0) <= x2 {
					if mouy(act_num, 0) >= y1 {
						if mouy(act_num, 0) <= y2 {
							re = 1
						}
					}
				}
			}
			if re = 0 : return 0

			if tv(act_num, PARAM_1, 0) > tv(act_num, PARAM_1, 1) : tv(act_num, PARAM_1, 0) = SARCH_TIME_MAX - tv(act_num, PARAM_1, 0) + tv(act_num, PARAM_1, 1)
			t = tv(act_num, PARAM_1, 1) - tv(act_num, PARAM_1, 0)
			if t < t_interval : return 0
			
			re = 0
			if moux(act_num, 0) >= x1 {
				if moux(act_num, 0) <= x2 {
					if mouy(act_num, 0) >= y1 {
						if mouy(act_num, 0) <= y2 {
							re = 1
						}
					}
				}
			}
			if re = 0 : return 0
	
			re = 0
			if moux(act_num, 1) >= x1 {
				if moux(act_num, 1) <= x2 {
					if mouy(act_num, 1) >= y1 {
						if mouy(act_num, 1) <= y2 {
							re = 1
						}
					}
				}
			}
			if re = 0 : return 0

			tv(act_num, PARAM_1, 0) = 0
			tv(act_num, PARAM_1, 1) = 0
			cp(act_num, PARAM_1)    = 2
			return 1

		}
	}

	if touch_key = 0 {
		i  = cp(act_num, PARAM_1)
		if i = 2 {

			if moux(act_num, 1) >= x1 {
				if moux(act_num, 1) <= x2 {
					if mouy(act_num, 1) >= y1 {
						if mouy(act_num, 1) <= y2 {
							tv(act_num, PARAM_1, 0) = 0
							tv(act_num, PARAM_1, 1) = 0
							cp(act_num, PARAM_1)    = 3
							return 2
						}
					}
				}
			}

		}			
	}

	tv(act_num, PARAM_1, 0) = 0
	tv(act_num, PARAM_1, 1) = 0
	tv(act_num, PARAM_1, 2) = 0
	tv(act_num, PARAM_1, 3) = 0
	cp(act_num, PARAM_1) = 0

	return 0


;-----------------------------------------------------
; smart_drag
;
; �h���b�O���擾
;
;
; act_num           : �A�N�V�������擾����A�N�V�����ԍ�
; x1, y1, x2, y2    : �h���b�O��F�������ʍ��W�̈�
; drag_interval     : �h���b�O�ƔF������܂ł̎���(�P�ʁF�~���b)�B�ȗ����́A1000�~���b�Ƃ���B
;
;
; �߂�l
;   0 = �h���b�O����Ă��Ȃ�
;   1 = �h���b�O����Ă���(��ʂɎw����������ꂽ)
;   2 = �h���b�O���I�����ꂽ(��ʂ���w�𗣂��ꂽ)
;
;
;=====================================================
; SAMPLE
;
;   smart_add : act_num = stat
;
;   repeat
;        redraw 0
;
;        color 255, 0, 0
;        boxf x, y, x + 200, y + 200
;
;        drag = smart_drag(act_num, x, y, x + 170, y + 50, 1000)
;
;        if drag = 0 {
;             start_x = mousex - x
;             start_y = mousey - y
;	     }
;        if drag = 1 {
;             x = mousex - start_x
;             y = mousey - start_y
;        }
;        if drag = 2 {
;             mes "DRAG FINISH"
;             wait 1000
;        }
;
;        redraw 1
;        wait 1
;   loop
;
;-----------------------------------------------------
#defcfunc smart_drag int act_num, int x1, int y1, int x2, int y2, int drag_interval

	t_interval = drag_interval
	if t_interval = 0 : t_interval = DEFAULT_DRAG_INTERVAL
	dim touch_id, 1 : mtlist touch_id : drag_key = stat

	if drag_key > 0 {
		i      = cp(act_num, PARAM_1)
		hour   = gettime(4) * 1000 * 60 * 60
		minute = gettime(5) * 1000 * 60
		second = gettime(6) * 1000
		tv(act_num, PARAM_1, i) = hour + minute + second + gettime(7)
		moux(act_num, i) = mousex
		mouy(act_num, i) = mousey

		if i = 0 {
			cp(act_num, PARAM_1) = 1
			return 0
		}
		
		if i = 1 {

			re = 0
			if moux(act_num, 0) >= x1 {
				if moux(act_num, 0) <= x2 {
					if mouy(act_num, 0) >= y1 {
						if mouy(act_num, 0) <= y2 {
							re = 1
						}
					}
				}
			}
			if re = 0 : return 0

			if tv(act_num, PARAM_1, 0) > tv(act_num, PARAM_1, 1) : tv(act_num, PARAM_1, 0) = SARCH_TIME_MAX - tv(act_num, PARAM_1, 0) + tv(act_num, PARAM_1, 1)
			t = tv(act_num, PARAM_1, 1) - tv(act_num, PARAM_1, 0)
			if t < t_interval : return 0

			moux(act_num, 0) = moux(act_num, 1)
			mouy(act_num, 0) = mouy(act_num, 1)
			
			re = 0
			if moux(act_num, 0) >= x1 {
				if moux(act_num, 0) <= x2 {
					if mouy(act_num, 0) >= y1 {
						if mouy(act_num, 0) <= y2 {
							re = 1
						}
					}
				}
			}
			if re = 0 : return 0
	
			re = 0
			if moux(act_num, 1) >= x1 {
				if moux(act_num, 1) <= x2 {
					if mouy(act_num, 1) >= y1 {
						if mouy(act_num, 1) <= y2 {
							re = 1
						}
					}
				}
			}
			if re = 0 {
				return 0
			} else {
				return 1
			}
		}
	}

	if drag_key = 0 {
		i  = cp(act_num, PARAM_1)
		if i = 1 {
			hour   = gettime(4) * 1000 * 60 * 60
			minute = gettime(5) * 1000 * 60
			second = gettime(6) * 1000
			tv(act_num, PARAM_1, i) = hour + minute + second + gettime(7)
			moux(act_num, i) = mousex
			mouy(act_num, i) = mousey
			if tv(act_num, PARAM_1, 0) > tv(act_num, PARAM_1, 1) : tv(act_num, PARAM_1, 0) = SARCH_TIME_MAX - tv(act_num, PARAM_1, 0) + tv(act_num, PARAM_1, 1)
			t = tv(act_num, PARAM_1, 1) - tv(act_num, PARAM_1, 0)

			if t >= t_interval {
				
				cp(act_num, PARAM_1) = 2
	
				re = 0
				if (moux(act_num, 0) >= x1) {
					if (moux(act_num, 0) <= x2) {
						if (mouy(act_num, 0) >= y1) {
							if (mouy(act_num, 0) <= y2) {
								re = 1
							}
						}
					}
				}
				if re = 0 : return 0
	
				re = 0
				if (moux(act_num, 1) >= x1) {
					if (moux(act_num, 1) <= x2) {
						if (mouy(act_num, 1) >= y1) {
							if (mouy(act_num, 1) <= y2) {
								re = 1
							}
						}
					}
				}
				if re = 0 {
					return 0
				} else {
					return 2
				}
			}
		}
	}

	tv(act_num, PARAM_1, 0) = 0
	tv(act_num, PARAM_1, 1) = 0
	tv(act_num, PARAM_1, 2) = 0
	tv(act_num, PARAM_1, 3) = 0
	cp(act_num, PARAM_1) = 0

	return 0


;-----------------------------------------------------
; smart_dtap
;
; �_�u���^�b�v���擾
;
;
; act_num             : �A�N�V�������擾����A�N�V�����ԍ�
; x1, y1, x2, y2      : �_�u���^�b�v��F�������ʍ��W
; double_tap_interval : �w��̎��Ԃ̊Ԃɉ�ʂ��w�ŉ����ė����ĉ����܂ł��_�u���^�b�v�ƔF������(�P�ʁF�~���b)�B�ȗ����́A700�~���b�Ƃ���B
;
;
; �߂�l
;   0 = �_�u���^�b�v����Ă��Ȃ�
;   1 = �P��ڂ̃^�b�v�����ꂽ(��ʂɎw������ꂽ)
;   2 = �P��ڂ̃^�b�v���I�����(��ʂ���w�𗣂��ꂽ)
;   3 = �Q��ڂ̃^�b�v(�_�u���^�b�v)�����ꂽ(��ʂɎw������ꂽ)
;
;
;=====================================================
; SAMPLE
;
;   smart_add
;   if smart_dtap(stat, 0, 0, 319, 479, 700) = 3 : mes "DOUBLE TAP OK"
;
;-----------------------------------------------------
#defcfunc smart_dtap int act_num, int x1, int y1, int x2, int y2, int double_tap_interval

	t_interval = double_tap_interval
	if t_interval = 0 : t_interval = DEFAULT_DOUBLE_TAP_INTERVAL
	dim touch_id, 1 : mtlist touch_id : double_tap_key = stat

	if double_tap_key > 0 {
		i      = cp(act_num, PARAM_1)
		hour   = gettime(4) * 1000 * 60 * 60
		minute = gettime(5) * 1000 * 60
		second = gettime(6) * 1000
		tv(act_num, PARAM_1, i) = hour + minute + second + gettime(7)
		moux(act_num, i) = mousex
		mouy(act_num, i) = mousey
		
		if i = 0 {
			cp(act_num, PARAM_1) = 1
			re = 0
			if moux(act_num, 0) >= x1 {
				if moux(act_num, 0) <= x2 {
					if mouy(act_num, 0) >= y1 {
						if mouy(act_num, 0) <= y2 {
							re = 1
						}
					}
				}
			}
			if re = 0 {
				return 0
			} else {
				return 1
			}
		}
		
		if i = 1 {
			re = 0
			if moux(act_num, 0) >= x1 {
				if moux(act_num, 0) <= x2 {
					if mouy(act_num, 0) >= y1 {
						if mouy(act_num, 0) <= y2 {
							re = 1
						}
					}
				}
			}
			if re = 0 : return 0

			re = 0
			if moux(act_num, 1) >= x1 {
				if moux(act_num, 1) <= x2 {
					if mouy(act_num, 1) >= y1 {
						if mouy(act_num, 1) <= y2 {
							re = 1
						}
					}
				}
			}
			if re = 0 : return 0
			
			if tv(act_num, PARAM_1, 0) > tv(act_num, PARAM_1, 1) : tv(act_num, PARAM_1, 0) = SARCH_TIME_MAX - tv(act_num, PARAM_1, 0) + tv(act_num, PARAM_1, 1)
			t = tv(act_num, PARAM_1, 1) - tv(act_num, PARAM_1, 0)
			if t > t_interval {
				return 0
			} else {
				return 1
			}
		}

		if i = 2 {
			re = 0
			if moux(act_num, 0) >= x1 {
				if moux(act_num, 0) <= x2 {
					if mouy(act_num, 0) >= y1 {
						if mouy(act_num, 0) <= y2 {
							re = 1
						}
					}
				}
			}
			if re = 0 : return 0

			re = 0
			if moux(act_num, 1) >= x1 {
				if moux(act_num, 1) <= x2 {
					if mouy(act_num, 1) >= y1 {
						if mouy(act_num, 1) <= y2 {
							re = 1
						}
					}
				}
			}
			if re = 0 : return 0
	
			re = 0
			if moux(act_num, 2) >= x1 {
				if moux(act_num, 2) <= x2 {
					if mouy(act_num, 2) >= y1 {
						if mouy(act_num, 2) <= y2 {
							re = 1
						}
					}
				}
			}
			if re = 0 : return 0

			if tv(act_num, PARAM_1, 0) > tv(act_num, PARAM_1, 2) : tv(act_num, PARAM_1, 0) = SARCH_TIME_MAX - tv(act_num, PARAM_1, 0) + tv(act_num, PARAM_1, 2)
			t = tv(act_num, PARAM_1, 2) - tv(act_num, PARAM_1, 0)
			if t > t_interval : return 0
			cp(act_num, PARAM_1) = 3
			return 3
		}
	
		if i = 3 : return 0
		
	}

	if double_tap_key = 0 {
		i  = cp(act_num, PARAM_1)
		if (i = 1) | (i = 2) {
			hour   = gettime(4) * 1000 * 60 * 60
			minute = gettime(5) * 1000 * 60
			second = gettime(6) * 1000
			tv(act_num, PARAM_1, i) = hour + minute + second + gettime(7)
			moux(act_num, i) = mousex
			mouy(act_num, i) = mousey
			if tv(act_num, PARAM_1, 0) > tv(act_num, PARAM_1, i) : tv(act_num, PARAM_1, 0) = SARCH_TIME_MAX - tv(act_num, PARAM_1, 0) + tv(act_num, PARAM_1, i)
			t = tv(act_num, PARAM_1, i) - tv(act_num, PARAM_1, 0)

			if t <= t_interval {

				cp(act_num, PARAM_1) = 2
	
				re = 0
				if (moux(act_num, 0) >= x1) {
					if (moux(act_num, 0) <= x2) {
						if (mouy(act_num, 0) >= y1) {
							if (mouy(act_num, 0) <= y2) {
								re = 1
							}
						}
					}
				}
				
				if re = 0 {
					cp(act_num, PARAM_1) = 0
					return 0
				}

				re = 0
				if (moux(act_num, i) >= x1) {
					if (moux(act_num, i) <= x2) {
						if (mouy(act_num, i) >= y1) {
							if (mouy(act_num, i) <= y2) {
								re = 1
							}
						}
					}
				}
				if re = 0 {
					return 0
				} else {
					return 2
				}
			}
		}
	}
	
	tv(act_num, PARAM_1, 0) = 0
	tv(act_num, PARAM_1, 1) = 0
	tv(act_num, PARAM_1, 2) = 0
	tv(act_num, PARAM_1, 3) = 0	
	cp(act_num, PARAM_1)    = 0

	return 0


;-----------------------------------------------------
; smart_vswipe
;
; �c�X���C�v���擾
;
;
; act_num           : �A�N�V�������擾����A�N�V�����ԍ�
; x1, y1, x2, y2    : �c�X���C�v��F�������ʍ��W
; swipe_interval    : �w��̎��Ԃ̊Ԃɉ�ʂ��w�ŉ����ė����܂ł��c�X���C�v�ƔF������(�P�ʁF�~���b)�B�ȗ����́A600�~���b�Ƃ���B
; min_movement      : �c�X���C�v�ƔF������c�̍ŏ��ړ���
; max_movement      : �c�X���C�v�ƔF������c�̍ő�ړ���
;
;
; �߂�l
;    0 = �X���C�v����Ă��Ȃ�
;    1 = �^�b�v�����ꂽ(��ʂɎw������ꂽ)
;
;    2 = �ォ�牺�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ) (�������w�𕥂���)
;    3 = �ォ�牺�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;    4 = �ォ�牺�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;    5 = �ォ�牺�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;    6 = �ォ�牺�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;    7 = �ォ�牺�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;    8 = �ォ�牺�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;    9 = �ォ�牺�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;   10 = �ォ�牺�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;   11 = �ォ�牺�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ) (�傫���w�𕥂���)
;
;   -2 = �������ɃX���C�v���ꂽ(��ʂ���w�������ꂽ) (�������w�𕥂���)
;   -3 = �������ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;   -4 = �������ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;   -5 = �������ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;   -6 = �������ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;   -7 = �������ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;   -8 = �������ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;   -9 = �������ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;  -10 = �������ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;  -11 = �������ɃX���C�v���ꂽ(��ʂ���w�������ꂽ) (�傫���w�𕥂���)
;
;=====================================================
; SAMPLE
;
;   smart_add
;	if smart_vswipe(stat, 0, 0, 319, 479, 400, 10, 479) = 2 : mes "VERTICAL SWIPE OK"
;
;-----------------------------------------------------
#defcfunc smart_vswipe int act_num, int x1, int y1, int x2, int y2, int swipe_interval, int min_movement, int max_movement

	t_interval = swipe_interval
	if t_interval = 0 : t_interval = DEFAULT_SWIPE_INTERVAL
	dim touch_id, 1 : mtlist touch_id : swipe_key = stat

	if swipe_key > 0 {
		i      = cp(act_num, PARAM_1)
		hour   = gettime(4) * 1000 * 60 * 60
		minute = gettime(5) * 1000 * 60
		second = gettime(6) * 1000
		tv(act_num, PARAM_1, i) = hour + minute + second + gettime(7)
		moux(act_num, i) = mousex
		mouy(act_num, i) = mousey
		
		if i = 0 {
			cp(act_num, PARAM_1) = 1
			re = 0
			if moux(act_num, 0) >= x1 {
				if moux(act_num, 0) <= x2 {
					if mouy(act_num, 0) >= y1 {
						if mouy(act_num, 0) <= y2 {
							re = 1
						}
					}
				}
			}
			if re = 0 {
				return 0
			} else {
				return 1
			}
		}
		
		if i = 1 {
			re = 0
			if moux(act_num, 0) >= x1 {
				if moux(act_num, 0) <= x2 {
					if mouy(act_num, 0) >= y1 {
						if mouy(act_num, 0) <= y2 {
							re = 1
						}
					}
				}
			}
			if re = 0 : return 0

			re = 0
			if moux(act_num, 1) >= x1 {
				if moux(act_num, 1) <= x2 {
					if mouy(act_num, 1) >= y1 {
						if mouy(act_num, 1) <= y2 {
							re = 1
						}
					}
				}
			}
			if re = 0 : return 0
			
			if tv(act_num, PARAM_1, 0) > tv(act_num, PARAM_1, 1) : tv(act_num, PARAM_1, 0) = SARCH_TIME_MAX - tv(act_num, PARAM_1, 0) + tv(act_num, PARAM_1, 1)
			t = tv(act_num, PARAM_1, 1) - tv(act_num, PARAM_1, 0)
			if (t > t_interval) & (t_interval ! -1) {
				return 0
			} else {
				return 1
			}
		}
	}

	if swipe_key = 0 {
		i  = cp(act_num, PARAM_1)
		if i = 1 {
			hour   = gettime(4) * 1000 * 60 * 60
			minute = gettime(5) * 1000 * 60
			second = gettime(6) * 1000
			tv(act_num, PARAM_1, i) = hour + minute + second + gettime(7)
			moux(act_num, i) = mousex
			mouy(act_num, i) = mousey
			if tv(act_num, PARAM_1, 0) > tv(act_num, PARAM_1, 1) : tv(act_num, PARAM_1, 0) = SARCH_TIME_MAX - tv(act_num, PARAM_1, 0) + tv(act_num, PARAM_1, 1)
			t = tv(act_num, PARAM_1, 1) - tv(act_num, PARAM_1, 0)

			if (t <= t_interval) | (t_interval = -1) {
				
				cp(act_num, PARAM_1) = 2
	
				re = 0
				if (moux(act_num, 0) >= x1) {
					if (moux(act_num, 0) <= x2) {
						if (mouy(act_num, 0) >= y1) {
							if (mouy(act_num, 0) <= y2) {
								re = 1
							}
						}
					}
				}
				if re = 0 : return 0
	
				re = 0
				if (moux(act_num, 1) >= x1) {
					if (moux(act_num, 1) <= x2) {
						if (mouy(act_num, 1) >= y1) {
							if (mouy(act_num, 1) <= y2) {
								re = 1
							}
						}
					}
				}
				if re = 0 : return 0

				move_way    = 0
				move_moment = 0
				move_moment = mouy(act_num, 0) - mouy(act_num, 1)
				abs_moment  = abs(move_moment)

				dim y_point, POINT_SPLIT
				
				y_point(0) = y1 + (abs(y1 - y2) / 10)
				repeat POINT_SPLIT
					y_point(cnt + 1) = y_point(cnt) + (abs(y1 - y2) / 10)
				loop

				re = 0
				if abs_moment >= min_movement {
					if abs_moment <= max_movement {
						re = 1
					}
				}
				if re = 0 : return 0
				
				if move_moment = 0 : return 0
				if move_moment < 0 : move_way = 1	;�ォ�牺
				if move_moment > 0 : move_way = 2	;�������

				if abs_moment >= y1 {
					if abs_moment <= y_point(0) {
						if move_way = 1 : return 2	;�ォ�牺
						if move_way = 2 : return -2	;�������
					}
				}
				if abs_moment > y_point(0) {
					if abs_moment <= y_point(1) {
						if move_way = 1 : return 3	;�ォ�牺
						if move_way = 2 : return -3	;�������
					}
				}
				if abs_moment > y_point(1) {
					if abs_moment <= y_point(2) {
						if move_way = 1 : return 4	;�ォ�牺
						if move_way = 2 : return -4	;�������
					}
				}
				if abs_moment > y_point(2) {
					if abs_moment <= y_point(3) {
						if move_way = 1 : return 5	;�ォ�牺
						if move_way = 2 : return -5	;�������
					}
				}
				if abs_moment > y_point(3) {
					if abs_moment <= y_point(4) {
						if move_way = 1 : return 6	;�ォ�牺
						if move_way = 2 : return -6	;�������
					}
				}
				if abs_moment > y_point(4) {
					if abs_moment <= y_point(5) {
						if move_way = 1 : return 7	;�ォ�牺
						if move_way = 2 : return -7	;�������
					}
				}
				if abs_moment > y_point(5) {
					if abs_moment <= y_point(6) {
						if move_way = 1 : return 8	;�ォ�牺
						if move_way = 2 : return -8	;�������
					}
				}
				if abs_moment > y_point(6) {
					if abs_moment <= y_point(7) {
						if move_way = 1 : return 9	;�ォ�牺
						if move_way = 2 : return -9	;�������
					}
				}
				if abs_moment > y_point(7) {
					if abs_moment <= y_point(8) {
						if move_way = 1 : return 10		;�ォ�牺
						if move_way = 2 : return -10	;�������
					}
				}
				if abs_moment > y_point(8) {
					if abs_moment <= y2 {
						if move_way = 1 : return 11		;�ォ�牺
						if move_way = 2 : return -11	;�������
					}
				}

			}
		}
	}
	
	tv(act_num, PARAM_1, 0) = 0
	tv(act_num, PARAM_1, 1) = 0
	tv(act_num, PARAM_1, 2) = 0
	tv(act_num, PARAM_1, 3) = 0
	cp(act_num, PARAM_1)    = 0

	return 0


;-----------------------------------------------------
; smart_hswipe
;
; ���X���C�v���擾
;
;
; act_num           : �A�N�V�������擾����A�N�V�����ԍ�
; x1, y1, x2, y2    : ���X���C�v��F�������ʍ��W
; swipe_interval    : �w��̎��Ԃ̊Ԃɉ�ʂ��w�ŉ����ė����܂ł����X���C�v�ƔF������(�P�ʁF�~���b)�B�ȗ����́A600�~���b�Ƃ���B
; min_movement      : ���X���C�v�ƔF������ŏ��ړ���
; max_movement      : ���X���C�v�ƔF������ő�ړ���
;
;
; �߂�l
;    0 = �X���C�v����Ă��Ȃ�
;    1 = �^�b�v�����ꂽ(��ʂɎw������ꂽ)
;
;    2 = ������E�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ) (�������w�𕥂���)
;    3 = ������E�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;    4 = ������E�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;    5 = ������E�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;    6 = ������E�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;    7 = ������E�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;    8 = ������E�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;    9 = ������E�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;   10 = ������E�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;   11 = ������E�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ) (�傫���w�𕥂���)
;
;   -2 = �E���獶�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ) (�������w�𕥂���)
;   -3 = �E���獶�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;   -4 = �E���獶�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;   -5 = �E���獶�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;   -6 = �E���獶�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;   -7 = �E���獶�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;   -8 = �E���獶�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;   -9 = �E���獶�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;  -10 = �E���獶�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ)
;  -11 = �E���獶�ɃX���C�v���ꂽ(��ʂ���w�������ꂽ) (�傫���w�𕥂���)
;
;=====================================================
; SAMPLE
;
;   smart_add
;	if smart_hswipe(stat, 0, 0, 319, 479, 400, 10, 319) = 2 : mes "HORIZON SWIPE OK"
;
;-----------------------------------------------------
#defcfunc smart_hswipe int act_num, int x1, int y1, int x2, int y2, int swipe_interval, int min_movement, int max_movement

	t_interval = swipe_interval
	if t_interval = 0 : t_interval = DEFAULT_SWIPE_INTERVAL
	dim touch_id, 1 : mtlist touch_id : swipe_key = stat

	if swipe_key > 0 {
		i      = cp(act_num, PARAM_1)
		hour   = gettime(4) * 1000 * 60 * 60
		minute = gettime(5) * 1000 * 60
		second = gettime(6) * 1000
		tv(act_num, PARAM_1, i) = hour + minute + second + gettime(7)
		moux(act_num, i) = mousex
		mouy(act_num, i) = mousey
		
		if i = 0 {
			cp(act_num, PARAM_1) = 1
			re = 0
			if moux(act_num, 0) >= x1 {
				if moux(act_num, 0) <= x2 {
					if mouy(act_num, 0) >= y1 {
						if mouy(act_num, 0) <= y2 {
							re = 1
						}
					}
				}
			}
			if re = 0 {
				return 0
			} else {
				return 1
			}
		}
		
		if i = 1 {
			re = 0
			if moux(act_num, 0) >= x1 {
				if moux(act_num, 0) <= x2 {
					if mouy(act_num, 0) >= y1 {
						if mouy(act_num, 0) <= y2 {
							re = 1
						}
					}
				}
			}
			if re = 0 : return 0

			re = 0
			if moux(act_num, 1) >= x1 {
				if moux(act_num, 1) <= x2 {
					if mouy(act_num, 1) >= y1 {
						if mouy(act_num, 1) <= y2 {
							re = 1
						}
					}
				}
			}
			if re = 0 : return 0
			
			if tv(act_num, PARAM_1, 0) > tv(act_num, PARAM_1, 1) : tv(act_num, PARAM_1, 0) = SARCH_TIME_MAX - tv(act_num, PARAM_1, 0) + tv(act_num, PARAM_1, 1)
			t = tv(act_num, PARAM_1, 1) - tv(act_num, PARAM_1, 0)
			if (t > t_interval) & (t_interval ! -1) {
				return 0
			} else {
				return 1
			}
		}
	}

	if swipe_key = 0 {
		i  = cp(act_num, PARAM_1)
		if i = 1 {
			hour   = gettime(4) * 1000 * 60 * 60
			minute = gettime(5) * 1000 * 60
			second = gettime(6) * 1000
			tv(act_num, PARAM_1, i) = hour + minute + second + gettime(7)
			moux(act_num, i) = mousex
			mouy(act_num, i) = mousey
			if tv(act_num, PARAM_1, 0) > tv(act_num, PARAM_1, 1) : tv(act_num, PARAM_1, 0) = SARCH_TIME_MAX - tv(act_num, PARAM_1, 0) + tv(act_num, PARAM_1, 1)
			t = tv(act_num, PARAM_1, 1) - tv(act_num, PARAM_1, 0)

			if (t <= t_interval) | (t_interval = -1) {
				
				cp(act_num, PARAM_1) = 2
	
				re = 0
				if (moux(act_num, 0) >= x1) {
					if (moux(act_num, 0) <= x2) {
						if (mouy(act_num, 0) >= y1) {
							if (mouy(act_num, 0) <= y2) {
								re = 1
							}
						}
					}
				}
				if re = 0 : return 0
	
				re = 0
				if (moux(act_num, 1) >= x1) {
					if (moux(act_num, 1) <= x2) {
						if (mouy(act_num, 1) >= y1) {
							if (mouy(act_num, 1) <= y2) {
								re = 1
							}
						}
					}
				}
				if re = 0 : return 0

				move_way    = 0
				move_moment = 0
				move_moment = moux(act_num, 0) - moux(act_num, 1)
				abs_moment  = abs(move_moment)

				dim x_point, POINT_SPLIT
				
				x_point(0)  = x1 + (abs(x1 - x2) / 10)
				repeat POINT_SPLIT
					x_point(cnt + 1) = x_point(cnt) + (abs(x1 - x2) / 10)
				loop

				re = 0
				if abs_moment >= min_movement {
					if abs_moment <= max_movement {
						re = 1
					}
				}
				if re = 0 : return 0
				
				if move_moment = 0 : return 0
				if move_moment < 0 : move_way = 1	;������E
				if move_moment > 0 : move_way = 2	;�E���獶

				if abs_moment >= x1 {
					if abs_moment <= x_point(0) {
						if move_way = 1 : return 2	;������E
						if move_way = 2 : return -2	;�E���獶
					}
				}
				if abs_moment > x_point(0) {
					if abs_moment <= x_point(1) {
						if move_way = 1 : return 3	;������E
						if move_way = 2 : return -3	;�E���獶
					}
				}
				if abs_moment > x_point(1) {
					if abs_moment <= x_point(2) {
						if move_way = 1 : return 4	;������E
						if move_way = 2 : return -4	;�E���獶
					}
				}
				if abs_moment > x_point(2) {
					if abs_moment <= x_point(3) {
						if move_way = 1 : return 5	;������E
						if move_way = 2 : return -5	;�E���獶
					}
				}
				if abs_moment > x_point(3) {
					if abs_moment <= x_point(4) {
						if move_way = 1 : return 6	;������E
						if move_way = 2 : return -6	;�E���獶
					}
				}
				if abs_moment > x_point(4) {
					if abs_moment <= x_point(5) {
						if move_way = 1 : return 7	;������E
						if move_way = 2 : return -7	;�E���獶
					}
				}
				if abs_moment > x_point(5) {
					if abs_moment <= x_point(6) {
						if move_way = 1 : return 8	;������E
						if move_way = 2 : return -8	;�E���獶
					}
				}
				if abs_moment > x_point(6) {
					if abs_moment <= x_point(7) {
						if move_way = 1 : return 9	;������E
						if move_way = 2 : return -9	;�E���獶
					}
				}
				if abs_moment > x_point(7) {
					if abs_moment <= x_point(8) {
						if move_way = 1 : return 10	;������E
						if move_way = 2 : return -10	;�E���獶
					}
				}
				if abs_moment > x_point(8) {
					if abs_moment <= x2 {
						if move_way = 1 : return 11	;�ォ�牺
						if move_way = 2 : return -11	;�������
					}
				}

			}
		}
	}
	
	tv(act_num, PARAM_1, 0) = 0
	tv(act_num, PARAM_1, 1) = 0
	tv(act_num, PARAM_1, 2) = 0
	tv(act_num, PARAM_1, 3) = 0
	cp(act_num, PARAM_1)    = 0

	return 0


;-----------------------------------------------------
; smart_one
;
; �^�b�v���ꂽ(��ʂ�������)�u�Ԃ���x�����擾�B(���������Ƃ��͊܂܂ꂸ)
;
;
; �߂�l
;    0 = �^�b�v����Ă��Ȃ�(�������͉����������Ă���)
;    1 = �^�b�v(��ʂ�������)�����ꂽ
;
;=====================================================
; SAMPLE
;
;*main
;
;	if smart_one() = 1 {
;		c++
;		mes "MOUSE LEFT BUTTON ONLY ONE = " + c
;	}
;	wait 1
;	goto *main
;
;-----------------------------------------------------
#defcfunc smart_one int dummy

	re = 0
	
	dim touch_id, 1 : mtlist touch_id : one_key = stat
	
	if one_key = 0 {
		one_click_left = 0
		return 0
	}

	if one_key > 0 {
		re = (one_click_left = 0)
		one_click_left = 1
	}

	return re


;-----------------------------------------------------
; smart_pinch
;
; �s���`�A�E�g/�C�����擾
;
;
; �߂�l
;    -1(�ȉ�) = �s���`�C������Ă���
;    0        = �X�N���[�����}���`�^�b�`����Ă��Ȃ�
;    1(�ȏ�)  = �s���`�A�E�g����Ă���
;
;=====================================================
; SAMPLE
;
;   smart_add : act_num = stat
;
;*main
;
;   redraw 0
;
;   i = smart_pinch(act_num)
;   pos 0, 0
;   if i = 0   : mes "NOT MULTI TOUCH"
;   if i >= 1  : mes "PINCH OUT"
;   if i <= -1 : mes "PINCH IN"
;
;   redraw 1
;	wait 1
;
;	goto *main
;
;-----------------------------------------------------
#defcfunc smart_pinch int act_num

	re = 0
	i  = 0
	dim touch_id, 1 : mtlist touch_id : tap_key = stat

	if tap_key > 1 {
		i = cp(act_num, PARAM_1)

		dim touch, 1
		repeat tap_key
			if cnt > 1 : break
			mtinfo touch, touch_id(cnt)
			c = i * 2 + cnt
			moux(act_num, c) = touch(1)
			mouy(act_num, c) = touch(2)
		loop

		if i = 0 {
			first_point_x  = abs(moux(act_num, 0) - moux(act_num, 1))
			first_point_y  = abs(mouy(act_num, 0) - mouy(act_num, 1))
			first_distance = (first_point_x * first_point_x) + (first_point_y * first_point_y)
			first_distance = int(sqrt(first_distance))
			cp(act_num, PARAM_1) = 1
			return 0
		}
		
		if i = 1 {
			touch_point_x = abs(moux(act_num, 2) - moux(act_num, 3))
			touch_point_y = abs(mouy(act_num, 2) - mouy(act_num, 3))
			touch_distance = (touch_point_x * touch_point_x) + (touch_point_y * touch_point_y)
			touch_distance = int(sqrt(touch_distance))
			re = touch_distance - first_distance
			return re
		}
	}

	cp(act_num, PARAM_1) = 0

	return 0


;-----------------------------------------------------
; smart_mtouch
;
; �w��̗̈�����^�b�`(�����Ō����^�b�`�Ƃ͉�ʂɐG��Ă���)���Ă��邩���擾
; �}���`�^�b�`�ɑΉ�
;
; x1 : ����X���W
; y1 : ����Y���W
; x2 : �E��X���W
; y2 : �E��Y���W
;
; �߂�l(0 = �w��̗̈�����^�b�`���Ă��Ȃ�)
;       (1 = �w��̗̈�����^�b�`���Ă���)
;
;=====================================================
; SAMPLE
;	if smart_mtouch(0, 0, 100, 200) = 1 : dialog "OK"
;-----------------------------------------------------
#defcfunc smart_mtouch int x1, int y1, int x2, int y2

	re       = 0
	mx       = 0
	my       = 0
	touch_id = 0

	mtlist touch_id : tap_key = stat

	if tap_key > 0 {
		dim touch, tap_key
		repeat tap_key
			mtinfo touch, touch_id(cnt)
			mx = touch(1)
			my = touch(2)
			if mx >= x1 {
				if mx <= x2 {
					if my >= y1 {
						if my <= y2 {
							re = 1
							break
						}
					}
				}
			}
		loop
	}

	return re


#global
