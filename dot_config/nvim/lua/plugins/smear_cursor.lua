return {
  "sphamba/smear-cursor.nvim",
  lazy = false, -- This makes so that you do not need to toggle it on the start
  opts = {
    smear_between_buffers = true,
    smear_between_neighbor_lines = true,
    scroll_buffer_space = true,
    legacy_computing_symbols_support = false,
    smear_insert_mode = true,

    stiffness = 0.7,                      -- 0.6      [0, 1]
    trailing_stiffness = 0.8,             -- 0.45     [0, 1]
    stiffness_insert_mode = 0.7,          -- 0.5      [0, 1]
    trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
    damping = 0.85,                       -- 0.85     [0, 1]
    damping_insert_mode = 0.95,           -- 0.9      [0, 1]
    distance_stop_animating = 0.4,        -- 0.1      > 0
    time_interval = 5,
  },
}
