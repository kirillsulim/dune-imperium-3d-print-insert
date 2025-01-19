/*
  https://github.com/dppdppd/The-Boardgame-Insert-Toolkit 
 */
include <vendor/boardgame_insert_toolkit_lib.3.scad>;

use <vendor/fonts/dune-rise/Dune_Rise.ttf>

d_font = "Dune Rise";

nozzle = 0.4;
walls = nozzle * 3;
lib_walls = 1.8;
bottom = 1.6;

lid_down_space = 3.5;
common_fr = 8;

heavy_enabled = true;

function vecsum(a, b) = 
    [a.x + b.x, a.y + b.y, a.z + b.z];

function cumsum(v) = 
    [for (a = [0, 0, 0], i = 0; i < len(v); a = vecsum(a, v[i]), i = i+1) vecsum(a, v[i])];
        
function cmp_offset(cmp_arr, i) = 
    i == 0? [0, 0] : [cumsum(cmp_arr)[i - 1].x + i * walls, 0];
    
function cmp_offset_y(cmp_arr, i) = 
    i == 0? [0, 0] : [0, cumsum(cmp_arr)[i - 1].y + i * walls];

box_space = [289, 289, 79];
rules = 4; 
boards = 14;
boards_ext = 11;
    
org_space = vecsum(box_space, [0, 0, - rules - boards]);

worm_token = [63, 63, 4];
    
imp_card = [67, 91, 0];
intr_card = [47, 72, 0];
start_deck = vecsum(imp_card, [0, 0, 7]); // 7 -> 8 if enough space
standard_market = vecsum(imp_card, [0, 0, 8]);
lansraad_market = vecsum(imp_card, [0, 0, 12]); // 10 + 2
folded_space_m1 = vecsum(imp_card, [0, 0, 5]);
commitet_cards = [58, 43, 20];
ix_cards = [68, 45, 32];
ix_cards_3 = [68, 45, 11];
hagal_cards = vecsum(imp_card, [0, 0, 24]); // 22 + 2
spice_cards = vecsum(imp_card, [0, 0, 13]); // 11 + 2
events_cards = vecsum(imp_card, [0, 0, 24]); // 22 + 2
tleilaxu_cards = vecsum(imp_card, [0, 0, 14]); // 12 + 2
extra_locations = [85, 71, 8];
round_cards = [66, 42, 16];
conflict_cards = vecsum(intr_card, [0, 0, 13]);
intr_deck = vecsum(intr_card, [0, 0, 40]);
weather_cards = vecsum(intr_card, [0, 0, 4]);
prophecy_cards = vecsum(intr_card, [0, 0, 30]); // 28 + 2
leaders = [106, 156, 22];
    
comp_space = vecsum(box_space, [0, 0, - rules]);

cards_cmp = [89, 64, 13];
disk_cmp = [21, 51, 21];
cube_cmp = [51, 31, 20];
    
function lid(text = "", lbl_size = AUTO, angle = 0) = 
    let (lid_rad = 6)
    let (lid_pattern_n = 12)
    let (lid_p_thick = 1)
    len(text) == 0 ? 
        [ BOX_LID, [
            [LID_PATTERN_RADIUS, lid_rad],
            [ LID_PATTERN_THICKNESS, lid_p_thick],
            [ LID_PATTERN_N1, lid_pattern_n ],
            [ LID_PATTERN_N2, lid_pattern_n ],
            [ LID_INSET_B, true],
            [ LID_NOTCHES_B, true],
            [ LID_FIT_UNDER_B, t ],
        ]]
    :
        [BOX_LID, [
            [LID_PATTERN_RADIUS, lid_rad],
            [ LID_PATTERN_THICKNESS, lid_p_thick],
            [ LID_PATTERN_N1, lid_pattern_n ],
            [ LID_PATTERN_N2, lid_pattern_n ],
            [ LID_INSET_B, true],


            [ LID_NOTCHES_B, true],
            [ LID_FIT_UNDER_B, t ],
            [ LABEL, [
                 [ LBL_TEXT, text ],
                 [ LBL_FONT, d_font ],
                 [ LBL_SIZE, lbl_size ],
                 [ ROTATION, angle ],
            ]],
            [LID_LABELS_INVERT_B, f],
            [ LID_STRIPE_WIDTH, 1,2 ],
        ]]
;


function no_lid() = 
    [ BOX_NO_LID_B, true ];
    
function label(text, angle = -90, size = AUTO) = 
    [ LABEL, [
        [ LBL_TEXT, text],
        [ LBL_FONT, d_font ],
        [ LBL_PLACEMENT, CENTER ],
        [ LBL_SIZE, size ],
        [ LBL_DEPTH, 0.6 ],
        [ ROTATION, angle ],
        [ POSITION_XY, [0, 0]], 
        [ ENABLED_B, heavy_enabled ],
    ]];
    
function cmp_a(cmp) =
    atan(cmp.y / cmp.x);
    

// Player box (x5)
pb_box_size = vecsum(imp_card, [2*walls, 2*walls, 22]);
pb_deck = vecsum(start_deck, [0, 0, 2]);
pb_l_offset = [0, 0, pb_deck.z];
pb_cmps = [
  vecsum([42, 35, 11], pb_l_offset), // Cubes + atomic token
  vecsum([pb_deck.x, 26, 11], pb_l_offset), // Round markers
  vecsum([pb_deck.x, 26, 11], pb_l_offset), // Agents + Dred
];
pb_cmps_add = [pb_deck.x - pb_cmps[0].x - walls-1, pb_cmps[0].y, pb_cmps[0].z];
pb = ["Player box", [
    [ BOX_SIZE_XYZ, pb_box_size ],
    [ BOX_STACKABLE_B, false ],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],    
        [ CMP_COMPARTMENT_SIZE_XYZ, pb_deck ],
        [ CMP_CUTOUT_SIDES_4B, [f, f, t, t]],
        [ CMP_CUTOUT_HEIGHT_PCT, 25 ],
        [ CMP_CUTOUT_WIDTH_PCT, 36 ],
    ]],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, FILLET ],    
        [ CMP_FILLET_RADIUS, common_fr ],
        [ CMP_COMPARTMENT_SIZE_XYZ, pb_cmps[0]],
        [ POSITION_XY, cmp_offset_y(pb_cmps, 0)], 
        label([["CUBES"]]),
    ]], 
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, FILLET ],    
        [ CMP_FILLET_RADIUS, common_fr ],
        [ CMP_COMPARTMENT_SIZE_XYZ, pb_cmps_add],
        [ POSITION_XY, [pb_cmps[0].x + walls, 0]], 
        label([["FLAGS"]]),
    ]], 
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, FILLET ],    
        [ CMP_FILLET_RADIUS, common_fr ],
        [ CMP_COMPARTMENT_SIZE_XYZ, pb_cmps[1]],
        [ POSITION_XY, cmp_offset_y(pb_cmps, 1)], 
        label([["MARKERS"]]),
    ]],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, FILLET ],    
        [ CMP_FILLET_RADIUS, common_fr ],
        [ CMP_COMPARTMENT_SIZE_XYZ, pb_cmps[2]],
        [ POSITION_XY, cmp_offset_y(pb_cmps, 2)], 
        label([["AGENTS"]]),
    ]], 
    lid("PLAYER", 6.5),
   
]];



market_f_size = 4.5;

// Common market
cm_box_size = [pb_box_size.y, org_space.x - pb_box_size.x, standard_market.z + bottom];
cm_cmp = [standard_market.y, standard_market.x, standard_market.z];
cm = ["Common market", [
    [ BOX_SIZE_XYZ, cm_box_size],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],
        [ CMP_COMPARTMENT_SIZE_XYZ, cm_cmp ],
        [ CMP_NUM_COMPARTMENTS_XY, [1, 3] ],
        [ CMP_PADDING_XY, [0, 5]],
        [ CMP_CUTOUT_SIDES_4B, [f, f, t, t]],
        [ CMP_CUTOUT_WIDTH_PCT, 50 ],
        [ CMP_CUTOUT_DEPTH_PCT, 3],
        label([["FOLDED SPACE"], ["ARRAKIS LIASON"], ["THE SPICE MUST FLOW"]], -cmp_a(cm_cmp), market_f_size),
    ]],
    no_lid(),
]];



cm_add = [cm_box_size.x, cm_box_size.y / 3, 0];



// Tleilaxu deck
td_box_size = vecsum(cm_add, [0, 0, tleilaxu_cards.z + bottom]);
td_cmp = [tleilaxu_cards.y, tleilaxu_cards.x, tleilaxu_cards.z];
td = ["Tleilaxu deck", [
    [ BOX_SIZE_XYZ, td_box_size],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],
        [ CMP_COMPARTMENT_SIZE_XYZ, td_cmp ],
        [ CMP_CUTOUT_SIDES_4B, [f, f, t, t]],
        [ CMP_CUTOUT_WIDTH_PCT, 50 ],
        [ CMP_CUTOUT_DEPTH_PCT, 3],
        label("TLEILAXU MARKET", 180 - cmp_a(td_cmp), market_f_size),
    ]],
    no_lid(),
]];

// Dangerouse spice
ds_box_size = vecsum(cm_add, [0, 0, td_box_size.z]);
ds_cmp = [spice_cards.y, spice_cards.x, spice_cards.z];
ds = ["Dangerouse spice", [
    [ BOX_SIZE_XYZ, ds_box_size],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],
        [ CMP_COMPARTMENT_SIZE_XYZ, ds_cmp ],
        [ CMP_CUTOUT_SIDES_4B, [f, f, t, t]],
        [ CMP_CUTOUT_WIDTH_PCT, 50 ],
        [ CMP_CUTOUT_DEPTH_PCT, 3],
        label("SPICE HARVEST", 180 - cmp_a(ds_cmp), market_f_size),
    ]],
    no_lid(),
]];

// Landsraad call
lc_box_size = vecsum(cm_add, [0, 0, td_box_size.z]);
lc_cmp = [lansraad_market.y, lansraad_market.x, lansraad_market.z];
lc = ["Forgiving argument", [
    [ BOX_SIZE_XYZ, lc_box_size],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],
        [ CMP_COMPARTMENT_SIZE_XYZ, lc_cmp ],
        [ CMP_CUTOUT_SIDES_4B, [f, f, t, t]],
        [ CMP_CUTOUT_WIDTH_PCT, 50 ],
        [ CMP_CUTOUT_DEPTH_PCT, 3],
        label("FORGIVING ARGUMENT", 180 - cmp_a(lc_cmp), market_f_size),
    ]],
    no_lid(),
]];

// Intrigue
intr_box_size = [intr_card.y + walls * 2, pb_box_size.y, 51];
intr_space_z = intr_box_size.z - 2 * walls;
intr_angle = acos(intr_space_z / (intr_card.x + 10));
intr_dead_space = intr_space_z * tan(intr_angle);
intr_space = [intr_card.y, intr_box_size.y - walls - intr_dead_space, intr_space_z];

intr = ["Intrigue deck", [
[ BOX_SIZE_XYZ, intr_box_size],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],    
        [ CMP_SHEAR, [0, intr_angle] ],
        [ CMP_COMPARTMENT_SIZE_XYZ, intr_space ],
        [ CMP_PADDING_XY, [0, 100]],
        [ CMP_CUTOUT_SIDES_4B, [t, f, f, f]],
        [ CMP_CUTOUT_TYPE, BOTH ],
        [ CMP_CUTOUT_WIDTH_PCT, 80 ],
        [ CMP_CUTOUT_DEPTH_PCT, 1],
    ]],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],    
        [ CMP_COMPARTMENT_SIZE_XYZ, intr_space ],
        [ POSITION_XY, [-0.3, 0]],
    ]],
    //*/
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, ROUND ],
        [ CMP_SHAPE_ROTATED_B, t ],
        [ CMP_NUM_COMPARTMENTS_XY, [1, 31]],
        [ CMP_SHEAR, [0, intr_angle] ],
        [ CMP_COMPARTMENT_SIZE_XYZ, [intr_space.x, 1, intr_space.z + 1] ],
    ]],/**/
    no_lid(),
]];

deck_box_size = [cm_box_size.x, (cm_box_size.y - pb_box_size.x)/2, 25.5];

// House hagal
hh_box_size = vecsum(deck_box_size, [0, 0, 5 - lid_down_space]);
hh_cmp = vecsum([hagal_cards.y, hagal_cards.x, hagal_cards.z], [0, 1, 1.4]);
hh = ["House Hagal deck", [
    [ BOX_SIZE_XYZ, hh_box_size],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],
        [ CMP_COMPARTMENT_SIZE_XYZ, hh_cmp ],
        [ CMP_PADDING_XY, [0, 100]],
        [ CMP_CUTOUT_SIDES_4B, [t, t, f, f]],
        [ CMP_CUTOUT_WIDTH_PCT, 50 ],
        [ CMP_CUTOUT_DEPTH_PCT, 3],
        label("HOUSE HAGAL", 180 - cmp_a(hh_cmp), 6.7),
    ]],
    lid("HAGAL",11),
]];


// Events
ev_box_size = vecsum(deck_box_size, [0, 0, 8 - lid_down_space]);
ev_cmp = vecsum([events_cards.y, events_cards.x, ev_box_size.z - bottom], [0, 1, 0]);
ev = ["events", [
    [ BOX_SIZE_XYZ, ev_box_size],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],
        [ CMP_COMPARTMENT_SIZE_XYZ, ev_cmp ],
        [ CMP_PADDING_XY, [0, 100]],
        [ CMP_CUTOUT_SIDES_4B, [t, t, f, f]],
        [ CMP_CUTOUT_WIDTH_PCT, 50 ],
        [ CMP_CUTOUT_DEPTH_PCT, 3],
        label("EVENTS", 180 - cmp_a(ev_cmp), 7.6),
    ]],
    lid("EVENTS",9.5),
]];

pr_box_size = [
  box_space.x - intr_box_size.x - pb_box_size.x, 
  prophecy_cards.z + walls * 3, 
  cm_box_size.z + ds_box_size.z + hh_box_size.z + lid_down_space
];
pr_cmp = vecsum([prophecy_cards.y, prophecy_cards.z, prophecy_cards.x], [0, walls/2, 3]);
rc_cmp = vecsum([round_cards.x, round_cards.z, round_cards.y], [3, 5, 2]);
pr = ["Prophecies", [
    [ BOX_SIZE_XYZ, pr_box_size],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],
        [ CMP_COMPARTMENT_SIZE_XYZ, pr_cmp ],
        [ CMP_PADDING_XY, [0, 100]],
        [ CMP_CUTOUT_SIDES_4B, [t, t, f, f]],
        [ CMP_CUTOUT_WIDTH_PCT, 50 ],
        [ CMP_CUTOUT_DEPTH_PCT, 3],
        [ POSITION_XY, [0, 0]],
        label("PROPHECIES", 0),
    ]],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],
        [ CMP_COMPARTMENT_SIZE_XYZ, rc_cmp ],
        [ CMP_PADDING_XY, [0, 100]],
        [ CMP_CUTOUT_SIDES_4B, [t, t, f, f]],
        [ CMP_CUTOUT_WIDTH_PCT, 50 ],
        [ CMP_CUTOUT_DEPTH_PCT, 3],
        [ POSITION_XY, [pr_cmp.x + walls, 0]],
        label("ROUND TOKENS", 0),
    ]],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],
        [ CMP_COMPARTMENT_SIZE_XYZ, [30, 20, 100] ],
        [ CMP_CUTOUT_BOTTOM_B, t ],
        [ CMP_CUTOUT_BOTTOM_PCT, 100 ],
        [ POSITION_XY, [120, rc_cmp.y + walls ]],
    ]],
    no_lid(),
]];

cmt_box_size = [
  commitet_cards.z + walls * 3,
  intr_box_size.y - rc_cmp.y - 2 * walls,
  pr_box_size.z
];
cmt_cmp = vecsum([commitet_cards.z, commitet_cards.x, commitet_cards.y], [2, 2, 3]);
cmt_mg = (cmt_box_size.y - cmt_cmp.y - 2*walls) / 2;
cmt = ["Commity", [
    [ BOX_SIZE_XYZ, cmt_box_size],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],
        [ CMP_COMPARTMENT_SIZE_XYZ, cmt_cmp ],
        [ CMP_PADDING_XY, [0, 0]],
        [ CMP_CUTOUT_SIDES_4B, [f, f, t, t]],
        [ CMP_CUTOUT_WIDTH_PCT, 50 ],
        [ CMP_CUTOUT_DEPTH_PCT, 3],
        [ CMP_MARGIN_FBLR, [cmt_mg, cmt_mg, 0, 0]],
        label("COMMITTEE", 90),
    ]],
    no_lid(),
]];





// Cards shoe
cs_box_size = [
  org_space.x - 2 * pb_box_size.y, 
  pb_box_size.x + intr_box_size.x + cmt_box_size.x, 
  org_space.z
];
cs_space_z = cs_box_size.z - 2 * walls;
cs_angle = acos(cs_space_z / (imp_card.x + 10));
cs_dead_space = cs_space_z * tan(cs_angle);
cs_space = [imp_card.y + 2, cs_box_size.y - 2 * walls - cs_dead_space, cs_space_z];

cs_off_x = (cs_box_size.x - cs_space.x - 3 * walls) / 2;

cs = ["Cards shoe", [
    [ BOX_SIZE_XYZ, cs_box_size],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],    
        [ CMP_SHEAR, [0, cs_angle] ],
        [ CMP_COMPARTMENT_SIZE_XYZ, cs_space ],
        [ CMP_PADDING_XY, [0, 100]],
        [ CMP_CUTOUT_SIDES_4B, [t, f, f, f]],
        [ CMP_CUTOUT_TYPE, BOTH ],
        [ CMP_CUTOUT_WIDTH_PCT, 80 ],
        [ CMP_CUTOUT_DEPTH_PCT, 1],
        [ POSITION_XY, [cs_off_x , 29]],
    ]],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],    
        [ CMP_COMPARTMENT_SIZE_XYZ, cs_space ],
        [ CMP_PADDING_XY, [0, 100]],
        [ POSITION_XY, [cs_off_x , 0]],
    ]],
    //*/
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, ROUND ],
        [ CMP_SHAPE_ROTATED_B, t ],
        [ CMP_NUM_COMPARTMENTS_XY, [1, 62]],
        [ CMP_SHEAR, [0, cs_angle] ],
        [ CMP_COMPARTMENT_SIZE_XYZ, [cs_space.x, 1, cs_space.z + 1] ],
        [ POSITION_XY, [cs_off_x , 21]],
    ]],/**/
    no_lid(),
]];

// Leaders box
ld_box_size = [
    box_space.x - cs_box_size.y,
    box_space.y - cm_box_size.x - pr_box_size.y,
    26,
];
ld_cmp = vecsum(leaders, [1, 1, 0]);
ldb = ["Leaders box", [
    [ BOX_SIZE_XYZ, ld_box_size],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],
        [ CMP_COMPARTMENT_SIZE_XYZ, ld_cmp ],
        //[ CMP_MARGIN_FBLR, [0, 0, 0, 0]],
        [ CMP_PADDING_XY, [5, 0]],
        [ POSITION_XY, [(ld_box_size.x - ld_cmp.x) / 2 - 1.8, (ld_box_size.y - ld_cmp.y) / 2 - 1.8] ],
        [ CMP_CUTOUT_SIDES_4B, [f, f, t, t]],
        [ CMP_CUTOUT_WIDTH_PCT, 50],
        [ CMP_CUTOUT_DEPTH_PCT, 3],
        [ CMP_CUTOUT_BOTTOM_B, t ],
        [ CMP_CUTOUT_BOTTOM_PCT, 100],
    ]],
    no_lid(),
]];

ldb_bottom = ["Leaders box", [
    [ BOX_SIZE_XYZ, ld_box_size],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],
        [ CMP_COMPARTMENT_SIZE_XYZ, ld_cmp ],
        //[ CMP_MARGIN_FBLR, [0, 0, 0, 0]],
        [ CMP_PADDING_XY, [25, 0]],
        [ POSITION_XY, [(ld_box_size.x - ld_cmp.x) / 2 - 1.8, (ld_box_size.y - ld_cmp.y) / 2 - 1.8] ],
        [ CMP_CUTOUT_SIDES_4B, [f, f, t, t]],
        [ CMP_CUTOUT_WIDTH_PCT, 50],
        [ CMP_CUTOUT_DEPTH_PCT, 3],
        label("LEADERS"),
    ]],
    no_lid(),
]];

// Ixian's technologies
ixt_box_size = [ld_box_size.y, ix_cards.x + walls * 3, ix_cards_3.z + 2 + bottom];
ixt_cmp = vecsum([ix_cards.y, ix_cards.x, ix_cards_3.z], [1, 1, 2]);
ixt_pd = (ixt_box_size.x - 3 * ixt_cmp.x) / 4;
ixt = ["Ix tech", [
    [ BOX_SIZE_XYZ, ixt_box_size],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],
        [ CMP_COMPARTMENT_SIZE_XYZ, ixt_cmp ],
        [ CMP_NUM_COMPARTMENTS_XY, [3,1]],
        [ CMP_PADDING_XY, [ixt_pd, 0]],
        [ CMP_CUTOUT_SIDES_4B, [t, t, f, f]],
        [ CMP_CUTOUT_WIDTH_PCT, 50 ],
        [ CMP_CUTOUT_DEPTH_PCT, 3],
        label([["IX TECH", "IX TECH", "IX TECH"]], 180 - cmp_a(ixt_cmp), 6),
    ]],
    no_lid(),
]];

// Multibox
mb_box_size = [ld_box_size.x - ixt_box_size.y, ld_box_size.y, ixt_box_size.z];
conflict_cmp = vecsum(conflict_cards, [1, 1, 0]);
weather_cmp = vecsum(weather_cards, [1, 1, 3]);
mb_factor = 0.6;
tok_cmp = [weather_cards.x * mb_factor, weather_cards.y * mb_factor, mb_box_size.z - bottom];
mb_pd = (mb_box_size.y - 2 * conflict_cmp.y) / 3;
mb_p0 = (mb_box_size.x - conflict_cmp.x) / 2;
mb = ["MB", [
    [ BOX_SIZE_XYZ, mb_box_size],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],
        [ CMP_COMPARTMENT_SIZE_XYZ, conflict_cmp ],
        [ CMP_PADDING_XY, [0, 1]],
        [ CMP_CUTOUT_SIDES_4B, [f, f, t, t]],
        [ CMP_CUTOUT_WIDTH_PCT, 50 ],
        [ CMP_CUTOUT_DEPTH_PCT, 3],
        [ POSITION_XY, [mb_p0- walls - 0.3, mb_pd]],
        label("Conflict", 180 - cmp_a(conflict_cmp), 6),
    ]],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],
        [ CMP_COMPARTMENT_SIZE_XYZ, weather_cmp ],
        [ CMP_PADDING_XY, [0, 1]],
        [ CMP_CUTOUT_SIDES_4B, [f, f, t, t]],
        [ CMP_CUTOUT_WIDTH_PCT, 50 ],
        [ CMP_CUTOUT_DEPTH_PCT, 3],
        [ POSITION_XY, [mb_p0- walls - 0.3, 2 * mb_pd +conflict_cmp.y ]],
    ]],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, FILLET ],
        [ CMP_FILLET_RADIUS, common_fr ],
        [ CMP_COMPARTMENT_SIZE_XYZ, tok_cmp ],
        [ POSITION_XY, [mb_p0- walls - 0.3 + (weather_cmp.x - tok_cmp.x)/2, 2 * mb_pd +conflict_cmp.y + (weather_cmp.y - tok_cmp.y)/2 ]],
        label("WEATHER", 90),
    ]],
    no_lid(),
]];

// Resources
rc_box_size = [
    cs_box_size.x, 
    ld_box_size.x, 
    cs_box_size.z - ld_box_size.z - ixt_box_size.z  - lid_down_space
];
rc_cmp_1 = [(rc_box_size.x - 3 * walls)/2, (rc_box_size.y - 4 * walls)/3, rc_box_size.z - bottom];
rc_cmp_2 = [(rc_box_size.x - 3 * walls)/2, (rc_box_size.y - 3 * walls)/2, rc_box_size.z - bottom];
rc = ["Resources", [
    [ BOX_SIZE_XYZ, rc_box_size],
    [ BOX_COMPONENT, [ 
        [ CMP_SHAPE, FILLET ],
        [ CMP_FILLET_RADIUS, common_fr ],
        [ CMP_COMPARTMENT_SIZE_XYZ, rc_cmp_1 ],
        [ CMP_NUM_COMPARTMENTS_XY, [1, 3]],
        [ POSITION_XY, [0, 0]],
    ]],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, FILLET ],
        [ CMP_FILLET_RADIUS, common_fr ],
        [ CMP_COMPARTMENT_SIZE_XYZ, rc_cmp_2 ],
        [ CMP_NUM_COMPARTMENTS_XY, [1, 2]],
        [ POSITION_XY, [rc_cmp_1.x + walls, 0]],
    ]],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],
        [ CMP_COMPARTMENT_SIZE_XYZ, rc_cmp_1 ],
        [ POSITION_XY, [rc_cmp_1.x - 20, 0]],
    ]],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],
        [ CMP_COMPARTMENT_SIZE_XYZ, rc_cmp_1 ],
        [ POSITION_XY, [rc_cmp_1.x - 20, 2 * rc_cmp_1.y + 2 * walls - 0.4 ]],
    ]],
    lid("RESOURCES", 8.3, 90),
    //no_lid()
]];

mb2_box_size = [
    ld_box_size.y - rc_box_size.x,
    rc_box_size.y,
    pr_box_size.z - ld_box_size.z - ixt_box_size.z  - lid_down_space
];
mb2_cmp_1 = [
    mb2_box_size.x - 2* walls,
    32,
    mb2_box_size.z - bottom
];
mb2_cmp_2 = [
    mb2_cmp_1.x,
    mb2_box_size.y - mb2_cmp_1.y - 3*walls,
    mb2_cmp_1.z
];
mb2 = ["Multibox 2", [
    [ BOX_SIZE_XYZ, mb2_box_size],
    [ BOX_COMPONENT, [ 
        [ CMP_SHAPE, FILLET ],
        [ CMP_FILLET_RADIUS, common_fr ],
        [ CMP_COMPARTMENT_SIZE_XYZ, mb2_cmp_1 ],
        [ POSITION_XY, [0, 0]],
    ]],
    [ BOX_COMPONENT, [ 
        [ CMP_SHAPE, FILLET ],
        [ CMP_FILLET_RADIUS, common_fr ],
        [ CMP_COMPARTMENT_SIZE_XYZ, mb2_cmp_2 ],
        [ POSITION_XY, [0, mb2_cmp_1.y + walls]],
    ]],
    lid("SETUP", 8.9, 90),
    //no_lid()
]];

imp_d = ["Imperial cards dividers", [
        [ TYPE,                     DIVIDERS ],
        [ DIV_FRAME_SIZE_XY, [imp_card.y, imp_card.x] ],
        [ DIV_TAB_SIZE_XY, [imp_card.y / 4, 4]],
        [ DIV_TAB_TEXT,             ["base","ix","im", "m1", "m2", "m4"]],
        [ DIV_TAB_TEXT_SIZE, 3.2 ],
        [ DIV_TAB_TEXT_FONT, d_font],
        [ DIV_FRAME_NUM_COLUMNS,    2 ],
        [ DIV_THICKNESS, 1 ],
]];

intr_d = ["Intrigue cards dividers", [
        [ TYPE,                     DIVIDERS ],
        [ DIV_FRAME_SIZE_XY, [intr_card.y - 3, intr_card.x] ],
        [ DIV_TAB_SIZE_XY, [intr_card.y / 3, 4]],
        [ DIV_TAB_TEXT,             ["base","ix","im", "m1"]],
        [ DIV_TAB_TEXT_SIZE, 3.2 ],
        [ DIV_TAB_TEXT_FONT, d_font],
        [ DIV_FRAME_NUM_COLUMNS,    2 ],
        [ DIV_THICKNESS, 1 ],
]];

data = [
  pb,
  lc,
  cm,
  td,
  ds,
  intr,
  hh,
  ev,
  pr,
  cmt,
  ixt,
  cs,
  ldb,
  ldb_bottom,
  mb,
  rc,
  mb2,
  imp_d,
  intr_d,
];


MakeAll();
