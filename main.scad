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
ix_cards_3 = [68, 45, 32, 11];
hagal_cards = vecsum(imp_card, [0, 0, 24]); // 22 + 2
spice_cards = vecsum(imp_card, [0, 0, 13]); // 11 + 2
events_cards = vecsum(imp_card, [0, 0, 24]); // 22 + 2
tleilaxu_cards = vecsum(imp_card, [0, 0, 14]); // 12 + 2
extra_locations = [85, 71, 8];
round_cards = [66, 42, 16];
conflict_cards = vecsum(intr_card, [0, 0, 13]);
intr_deck = vecsum(intr_card, [0, 0, 40]);
weather_cards = vecsum(intr_card, [0, 0, 40]);
prophecy_cards = vecsum(intr_card, [0, 0, 28]);
leaders = [106, 156, 22];
    
comp_space = vecsum(box_space, [0, 0, - rules]);

cards_cmp = [89, 64, 13];
disk_cmp = [21, 51, 21];
cube_cmp = [51, 31, 20];
    
function lid(text = "", lbl_size = AUTO) = 
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
                 [ ROTATION, 0 ],
                 [ LBL_FONT, d_font ],
                 [ LBL_SIZE, lbl_size ],
            ]],
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

// Cards shoe
cs_box_size = [org_space.x - 2 * pb_box_size.y, org_space.y, org_space.z];
cs_space_z = cs_box_size.z - 2 * walls;
cs_angle = acos(cs_space_z / (imp_card.x + 10));
cs_dead_space = cs_space_z * tan(cs_angle);
cs_space = [imp_card.y, cs_box_size.y - 2 * walls - cs_dead_space, cs_space_z];

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
    ]],
    //*/
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, ROUND ],
        [ CMP_SHAPE_ROTATED_B, t ],
        [ CMP_NUM_COMPARTMENTS_XY, [1, 118]],
        [ CMP_SHEAR, [0, cs_angle] ],
        [ CMP_COMPARTMENT_SIZE_XYZ, [cs_space.x, 1, cs_space.z + 1] ],
    ]],/**/
    no_lid(),
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

// Leaders box
ld_box_size = vecsum(leaders, [2*walls, 2*walls, walls+1]);
ld_cmp = leaders;
ld = ["Leaders box", [
    [ BOX_SIZE_XYZ, ld_box_size],
    [ BOX_COMPONENT, [
        [CMP_SHAPE, SQUARE],
        [ CMP_COMPARTMENT_SIZE_XYZ, ld_cmp ],
        [ CMP_CUTOUT_SIDES_4B, [f, f, t, t]],
        [ CMP_CUTOUT_WIDTH_PCT, 50 ],
        [ CMP_CUTOUT_DEPTH_PCT, 3],
        label([["LEADERS"]]),
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
hh_cmp = vecsum([hagal_cards.y, hagal_cards.x, hagal_cards.z], [0, 2, 1.4]);
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
    lid("HOUSE HAGAL",5),
    //no_lid(),
]];



// Folded space m1
fsm1_box_size = [deck_box_size.x, deck_box_size.y, 7];
fsm1_cmp = [imp_card.y, imp_card.x + 2, 5];
fsm1 = ["Folded space m1", [
    [ BOX_SIZE_XYZ, fsm1_box_size],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],
        [ CMP_COMPARTMENT_SIZE_XYZ, fsm1_cmp ],
        [ CMP_PADDING_XY, [0, 100]],
        [ CMP_CUTOUT_SIDES_4B, [t, t, f, f]],
        [ CMP_CUTOUT_WIDTH_PCT, 50 ],
        [ CMP_CUTOUT_DEPTH_PCT, 3],
        label("FOLDED SPACE M1", 180 - cmp_a(fsm1_cmp), market_f_size),
    ]],
    no_lid(),
]];

// Events
ev_box_size = vecsum(deck_box_size, [0, 0, 8 - fsm1_box_size.z]);
ev_cmp = vecsum([events_cards.y, events_cards.x, events_cards.z], [0, 2, 0.8]);
ev = ["events", [
    [ BOX_SIZE_XYZ, ev_box_size],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, SQUARE ],
        [ CMP_COMPARTMENT_SIZE_XYZ, ev_cmp ],
        [ CMP_PADDING_XY, [0, 100]],
        [ CMP_CUTOUT_SIDES_4B, [t, t, f, f]],
        [ CMP_CUTOUT_WIDTH_PCT, 50 ],
        [ CMP_CUTOUT_DEPTH_PCT, 3],
        label("EVENTS", 180 - cmp_a(ev_cmp), 8),
    ]],
    no_lid(),
]];

data = [
  //pb,
  // cs,
  // ld,
  // lc,
  //cm,
  //td,
  // ds,
  //intr,
  hh,
  ev,
  fsm1,
];


MakeAll();
