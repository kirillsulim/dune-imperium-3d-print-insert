/*
 https://github.com/dppdppd/The-Boardgame-Insert-Toolkit
 */
include <vendor/boardgame_insert_toolkit_lib.3.scad>;

nozzle = 0.4;
walls = nozzle * 3;
lib_walls = 1.8;

lid_down_space = 4;
common_fr = 8;

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
standarf_market = vecsum(imp_card, [0, 0, 7]);
lansraad_market = vecsum(imp_card, [0, 0, 8]); // 10 if enough space
folded_space_m1 = vecsum(imp_card, [0, 0, 5]);
commitet_cards = [58, 43, 20];
ix_cards = [68, 45, 32];
ix_cards_3 = [68, 45, 32, 11];
hagal_cards = vecsum(imp_card, [0, 0, 22]);
spice_cards = vecsum(imp_card, [0, 0, 11]);
events_cards = vecsum(imp_card, [0, 0, 30]);
tleilaxu_cards = vecsum(imp_card, [0, 0, 10]);
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
    
function lid() = 
    let (lid_rad = 8)
    let (lid_pattern_n = 6)
    let (lid_p_thick = 1)
    [ BOX_LID, [
        [LID_PATTERN_RADIUS, lid_rad],
        [ LID_PATTERN_THICKNESS, lid_p_thick],
        [ LID_PATTERN_N1, lid_pattern_n ],
        [ LID_PATTERN_N2, lid_pattern_n ],
        [ LID_INSET_B, true],
        [ LID_NOTCHES_B, true],
        [ LID_FIT_UNDER_B, t ],
    ]];

function no_lid() = 
    [ BOX_NO_LID_B, true ];

// Player box (x5)
pb_box_size = vecsum(imp_card, [2*walls, 2*walls, 22]);
pb_deck = vecsum(start_deck, [0, 0, 1]);
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
        [ CMP_CUTOUT_SIDES_4B, [f, f, t, t]],
        [ CMP_CUTOUT_HEIGHT_PCT, 25 ],
    ]],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, FILLET ],    
        [ CMP_FILLET_RADIUS, common_fr ],
        [ CMP_COMPARTMENT_SIZE_XYZ, pb_cmps[0]],
        [ POSITION_XY, cmp_offset_y(pb_cmps, 0)], 
    ]], 
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, FILLET ],    
        [ CMP_FILLET_RADIUS, common_fr ],
        [ CMP_COMPARTMENT_SIZE_XYZ, pb_cmps_add],
        [ POSITION_XY, [pb_cmps[0].x + walls, 0]], 
    ]], 
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, FILLET ],    
        [ CMP_FILLET_RADIUS, common_fr ],
        [ CMP_COMPARTMENT_SIZE_XYZ, pb_cmps[1]],
        [ POSITION_XY, cmp_offset_y(pb_cmps, 1)], 
    ]],
    [ BOX_COMPONENT, [
        [ CMP_SHAPE, FILLET ],    
        [ CMP_FILLET_RADIUS, common_fr ],
        [ CMP_COMPARTMENT_SIZE_XYZ, pb_cmps[2]],
        [ POSITION_XY, cmp_offset_y(pb_cmps, 2)], 
    ]], 
    lid(),
   
]];

data = [
  pb,
];

MakeAll();
