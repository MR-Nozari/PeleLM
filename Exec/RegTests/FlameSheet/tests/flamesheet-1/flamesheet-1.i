#----------------------DOMAIN DEFINITION------------------------
geometry.is_periodic = 1 1 0              # For each dir, 0: non-perio, 1: periodic
geometry.coord_sys   = 0                  # 0 => cart, 1 => RZ
geometry.prob_lo     = 0.0 0.0 0.0        # x_lo y_lo (z_lo)
geometry.prob_hi     = 0.016 0.016 0.016  # x_hi y_hi (z_hi)

# >>>>>>>>>>>>>  BC FLAGS <<<<<<<<<<<<<<<<
# Interior, Inflow, Outflow, Symmetry,
# SlipWallAdiab, NoSlipWallAdiab, SlipWallIsotherm, NoSlipWallIsotherm
peleLM.lo_bc = Interior  Interior Inflow
peleLM.hi_bc = Interior  Interior Outflow

#-------------------------AMR CONTROL----------------------------
amr.n_cell          = 32 32 32         # Level 0 number of cells in each direction   
amr.v               = 1                # AMR verbose
amr.max_level       = 0                # maximum level number allowed
amr.ref_ratio       = 2 2 2 2          # refinement ratio
amr.regrid_int      = 2                # how often to regrid
amr.n_error_buf     = 1 1 2 2          # number of buffer cells in error est
amr.grid_eff        = 0.7              # what constitutes an efficient grid
amr.blocking_factor = 16               # block factor in grid generation (min box size)
amr.max_grid_size   = 64               # max box size

#----------------------TIME STEPING CONTROL----------------------
max_step            = 2               # maximum number of time steps    
stop_time           = 0.04             # final physical time
ns.cfl              = 0.3              # cfl number for hyperbolic system
ns.init_shrink      = 0.0001           # scale back initial timestep
ns.change_max       = 1.1              # max timestep size increase
ns.dt_cutoff        = 5.e-10           # level 0 timestep below which we halt

#-------------------------IO CONTROL----------------------------
amr.checkpoint_files_output = 0
amr.check_file          = chk          # root name of checkpoint file
amr.check_int           = 5            # number of timesteps between checkpoints
amr.plot_file           = plt_         # root name of plot file
amr.plot_int            = 100          # number of timesteps between plot files
amr.derive_plot_vars    = rhoRT mag_vort avg_pressure gradpx gradpy sumRhoYdot mass_fractions molweight rhominsumrhoY cc_transport_coeffs cpmix mixfrac_only enthalpy
amr.grid_log            = grdlog       # name of grid logging file

#----------------------- PROBLEM PARAMETERS---------------------
prob.P_mean = 101325.0
prob.standoff = -.022
prob.pertmag = 0.0004
prob.pmf_datafile = "drm19_pmf.dat"

#--------------------REFINEMENT CONTROL------------------------
amr.refinement_indicators = flame_tracer 
amr.flame_tracer.max_level     = 3
amr.flame_tracer.value_greater = 1.e-6
amr.flame_tracer.field_name    = Y(H)

# Refinement according to temperature and gradient of temperature
#amr.refinement_indicators = lo_temp gradT
#amr.lo_temp.max_level = 2
#amr.lo_temp.value_less = 500
#amr.lo_temp.field_name = temp

#amr.gradT.max_level = 2
#amr.gradT.adjacent_difference_greater = 300
#amr.gradT.field_name = temp

# Refinement according to the vorticity, no field_name needed
#amr.refinement_indicators = magvort
#amr.magvort.max_level = 3
#amr.magvort.vorticity_greater = 300

#---------------------PHYSICS CONTROL------------------------
ns.fuelName          = H2              # Fuel species name
ns.unity_Le          = 0               # Use unity Le number transport ?
ns.hack_nochem       = 0               # Bypass chemistry ? 0: no, 1: yes
ns.gravity           = 0               # body force  (gravity in MKS units)
peleLM.mixtureFraction.format = Cantera
peleLM.mixtureFraction.type   = mole
peleLM.mixtureFraction.oxidTank = O2:0.21 N2:0.79
peleLM.mixtureFraction.fuelTank = CH4:0.0414 H2:0.0412

#--------------------NUMERICS CONTROL------------------------
ns.init_iter         = 3               # Number of initial iterations to def pressure
ns.num_divu_iters    = 1               # Number of DivU iteration at initialization
ns.sdc_iterMAX       = 2               # Number of SDC iterations
ns.num_mac_sync_iter = 2               # Number of mac_sync iterations

# --------------- INPUTS TO CHEMISTRY REACTOR ---------------
peleLM.chem_integrator = "ReactorCvode"
peleLM.use_typ_vals_chem = 1          # Use species/temp typical values in CVODE   
ode.rtol = 1.0e-6                     # Relative tolerance of the chemical solve
ode.atol = 1.0e-5                     # Absolute tolerance factor applied on typical values
cvode.solve_type = denseAJ_direct     # CVODE Linear solve type (for Newton direction) 
cvode.max_order  = 4                  # CVODE max BDF order. 

# ------------------  INPUTS TO ACTIVE CONTROL  ----------------------
active_control.on = 0                  # Use AC ?
active_control.use_temp = 1            # Default in fuel mass, rather use iso-T position ?
active_control.temperature = 1300.0    # Value of iso-T ?
active_control.tau = 1.0e-4            # Control tau (should ~ 10 dt)
active_control.height = 0.0070         # Where is the flame held ? Default assumes coordinate along Y in 2D or Z in 3D.
active_control.v = 1                   # verbose
active_control.velMax = 1.5            # Optional: limit inlet velocity
active_control.changeMax = 0.2         # Optional: limit inlet velocity changes (absolute)
active_control.flameDir  = 2           # Optional: flame main direction. Default: AMREX_SPACEDIM-1

# ---------------------------------------------------------------
# ------------------  ADVANCED USER INPUTS ----------------------
# ---------------------------------------------------------------

#----------------  ADV ALGORITHM CONTROL  -------------------
ns.sum_interval      = 5               # timesteps between computing mass
ns.do_reflux         = 1               # 1 => do refluxing
ns.do_mac_proj       = 1               # 1 => do MAC projection
ns.do_sync_proj      = 1               # 1 => do Sync Project
ns.divu_relax_factor = 0.0
ns.be_cn_theta       = 0.5
ns.do_temp           = 1
ns.do_diffuse_sync   = 1
ns.do_reflux_visc    = 1
ns.zeroBndryVisc     = 1
ns.v                 = 1

# 
ns.divu_ceiling         = 1
ns.divu_dt_factor       = .4
ns.min_rho_divu_ceiling = .01

# ------------------  INPUTS TO DIFFUSION CLASS --------------------
ns.visc_tol              = 1.0e-12     # tolerence for viscous solves
ns.visc_abs_tol          = 1.0e-12     # tolerence for viscous solves
diffuse.max_order        = 4
diffuse.tensor_max_order = 4
diffuse.v                = 0

# ------------------  INPUTS TO PROJECTION CLASS -------------------
proj.proj_tol            = 1.0e-12     # tolerence for projections
proj.proj_abs_tol        = 1.0e-12 
proj.sync_tol            = 1.0e-12     # tolerence for projections
proj.rho_wgt_vel_proj    = 0           # 0 => const den proj, 1 => rho weighted
proj.do_outflow_bcs      = 0
proj.divu_minus_s_factor = .5
proj.divu_minus_s_factor = 0.
proj.proj_2              = 1
nodal_proj.verbose       = 0
proj.v                   = 0

# ------------------  INPUTS TO MACPROJ CLASS -------------------
mac.mac_tol              = 1.0e-12     # tolerence for mac projections
mac.mac_sync_tol         = 1.0e-12     # tolerence for mac SYNC projection
mac.mac_abs_tol          = 1.0e-12
mac.do_outflow_bcs       = 0
mac.v                    = 0

#--------------------------OMP TILE INPUTS-----------------------------
#fabarray.mfiter_tile_size = 8 8 8

#--------------------------DEBUG/REGTESTS INPUTS-----------------------------
amrex.regtest_reduction=1
amrex.fpe_trap_invalid = 1
amrex.fpe_trap_zero = 1
amrex.fpe_trap_overflow = 1

#-----------------INPUTS FOR EMBEDDED BOUNDARIES---------------------
eb2.geom_type = "all_regular"
