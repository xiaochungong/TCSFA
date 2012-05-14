#include '../../../include/inc_rk4.h'
#include '../../../include/inc_atom.h'
#include '../../../include/inc_misc.h'
#include '../../../include/inc_field.h'

!#define ACTION_W_SUB action_w_sub_0_0_0_ana
#define ACTION_W_SUB action_w_sub_1_0_0_ana

subroutine sub_ptb_prop_0( ts, ierr, z_t0, x_t0, vz_t0, vx_t0, w_sub_0, &
      w_sub_r_recp, w_sub_r_recp_abs, err_spe, tag )
    use mod_sub_ptb_prop, only: m_t0, m_ti
    implicit none
    double complex, intent(in):: ts
    double complex:: w_sub_0, w_sub_r_recp, w_sub_r_recp_abs
    integer:: ierr, tag
    integer, parameter:: nt = RK4_NT
    integer, parameter:: ne = RK4_NE
    double precision, parameter:: Ip = IONIZATION_IP
    double complex, parameter:: eye = dcmplx(0d0, 1d0)
    double precision:: h
    double complex:: t, y_actual(ne)
    double complex, external:: sub_traj_x_0, sub_traj_z_0
    double complex, external:: sub_traj_vx_0, sub_traj_vz_0
    double complex, intent(out):: z_t0, x_t0, vz_t0, vx_t0
    double precision, intent(out):: err_spe
    double complex:: vz_ts, vx_ts
    integer:: i
    
    m_t0 = dreal(ts)
    m_ti = dimag(ts)

#ifdef MISC_PLOT_TRAJ
    call rk4_plot_init(1, tag)
    call rk4_plot_open_file()
    h = (0d0 - m_ti) / (nt - 1d0)
    do i = 1, nt
        t = dcmplx( m_t0, m_ti + h * (i-1) )
        y_actual(1) = sub_traj_x_0(t, ts)
        y_actual(2) = sub_traj_vx_0(t)
        y_actual(3) = sub_traj_z_0(t, ts)
        y_actual(4) = sub_traj_vz_0(t)
        call rk4_plot_write_cmplx( i, dimag(t), y_actual, h, 0 )
    end do
    call rk4_plot_close_file()
#endif

    z_t0 = sub_traj_z_0(dcmplx(m_t0, 0d0), ts)
    x_t0 = sub_traj_x_0(dcmplx(m_t0, 0d0), ts)
    vz_t0 = sub_traj_vz_0(dcmplx(m_t0, 0d0))
    vx_t0 = sub_traj_vx_0(dcmplx(m_t0, 0d0))
    call ACTION_W_SUB( ts, w_sub_0, w_sub_r_recp, w_sub_r_recp_abs )
!    call ACTION_W_SUB( ts, w_sub_0, w_sub_r_recp )
    w_sub_r_recp_abs=0d0

    vz_ts = sub_traj_vz_0(ts)
    vx_ts = sub_traj_vx_0(ts)
    err_spe = cdabs(0.5 * (vz_ts*vz_ts + vx_ts*vx_ts) + Ip)
    ierr = 0
    return
    
end subroutine sub_ptb_prop_0