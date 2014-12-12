{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 7,
			"minor" : 0,
			"revision" : 0,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"rect" : [ 34.0, 79.0, 966.0, 710.0 ],
		"bglocked" : 0,
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 1,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 1,
		"objectsnaponopen" : 1,
		"statusbarvisible" : 2,
		"toolbarvisible" : 1,
		"lefttoolbarpinned" : 0,
		"toptoolbarpinned" : 0,
		"righttoolbarpinned" : 0,
		"bottomtoolbarpinned" : 0,
		"toolbars_unpinned_last_save" : 0,
		"tallnewobj" : 0,
		"boxanimatetime" : 200,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"description" : "",
		"digest" : "",
		"tags" : "",
		"style" : "",
		"subpatcher_template" : "",
		"boxes" : [ 			{
				"box" : 				{
					"id" : "obj-20",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 4,
					"outlettype" : [ "signal", "signal", "signal", "signal" ],
					"patching_rect" : [ 720.400024, 664.0, 151.0, 22.0 ],
					"style" : "",
					"text" : "OSCswitch 8000 /1/fader1"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-18",
					"maxclass" : "newobj",
					"numinlets" : 6,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 598.0, 323.0, 107.0, 22.0 ],
					"style" : "",
					"text" : "scale 0. 2.5 -1. -6."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-16",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 928.5, 454.0, 32.0, 22.0 ],
					"style" : "",
					"text" : "*~ 4"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-13",
					"maxclass" : "newobj",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 711.5, 454.0, 32.0, 22.0 ],
					"style" : "",
					"text" : "*~ 4"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-5",
					"maxclass" : "live.gain~",
					"numinlets" : 2,
					"numoutlets" : 5,
					"orientation" : 1,
					"outlettype" : [ "signal", "signal", "", "float", "list" ],
					"parameter_enable" : 1,
					"patching_rect" : [ 711.5, 514.0, 136.0, 48.0 ],
					"presentation_rect" : [ 0.0, 0.0, 50.0, 48.0 ],
					"saved_attribute_attributes" : 					{
						"valueof" : 						{
							"parameter_longname" : "live.gain~[56]",
							"parameter_shortname" : "live.gain~[56]",
							"parameter_type" : 0,
							"parameter_mmin" : -70.0,
							"parameter_mmax" : 6.0,
							"parameter_initial" : [ 0.0 ],
							"parameter_unitstyle" : 4
						}

					}
,
					"varname" : "live.gain~"
				}

			}
, 			{
				"box" : 				{
					"bgmode" : 0,
					"border" : 0,
					"clickthrough" : 0,
					"enablehscroll" : 0,
					"enablevscroll" : 0,
					"id" : "obj-17",
					"lockeddragscroll" : 0,
					"maxclass" : "bpatcher",
					"name" : "automate2.maxpat",
					"numinlets" : 1,
					"numoutlets" : 2,
					"offset" : [ 0.0, 0.0 ],
					"outlettype" : [ "signal", "signal" ],
					"patching_rect" : [ 711.5, 208.0, 236.0, 234.0 ],
					"viewvisibility" : 1
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-15",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 800.0, 609.0, 66.0, 22.0 ],
					"style" : "",
					"text" : "clip~ -1. 1."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-8",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 0,
					"patching_rect" : [ 706.0, 732.0, 67.0, 22.0 ],
					"style" : "",
					"text" : "dac~ 1 2 3"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-11",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 345.0, 75.0, 68.0, 22.0 ],
					"style" : "",
					"text" : "port 12345"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-14",
					"linecount" : 2,
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 131.0, 89.0, 50.0, 35.0 ],
					"style" : "",
					"text" : "/speed -0."
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"format" : 6,
					"id" : "obj-12",
					"maxclass" : "flonum",
					"maximum" : 2.5,
					"minimum" : 0.0,
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 776.0, 168.0, 50.0, 22.0 ],
					"style" : ""
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-10",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 776.0, 125.0, 107.0, 22.0 ],
					"style" : "",
					"text" : "receive udpSpeed"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-9",
					"maxclass" : "newobj",
					"numinlets" : 3,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 712.0, 609.0, 66.0, 22.0 ],
					"style" : "",
					"text" : "clip~ -1. 1."
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-7",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 461.399994, 159.0, 150.0, 20.0 ],
					"style" : "",
					"text" : "Direction -> 1 ou -1"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-3",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 444.399994, 233.0, 75.0, 22.0 ],
					"style" : "",
					"text" : "send udpDir"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-4",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 461.399994, 207.0, 50.0, 22.0 ],
					"style" : "",
					"text" : "1."
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-1",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 339.399994, 233.0, 95.0, 22.0 ],
					"style" : "",
					"text" : "send udpSpeed"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-2",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 363.399994, 207.0, 50.0, 22.0 ],
					"style" : "",
					"text" : "-0."
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-6",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 258.399994, 233.0, 67.0, 22.0 ],
					"style" : "",
					"text" : "send udpZ"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-176",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 212.0, 16.0, 123.0, 22.0 ],
					"style" : "",
					"text" : "loadmess port 12345"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-157",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 275.399994, 207.0, 71.600006, 22.0 ],
					"style" : "",
					"text" : "65.464363"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-184",
					"maxclass" : "newobj",
					"numinlets" : 6,
					"numoutlets" : 6,
					"outlettype" : [ "", "", "", "", "", "" ],
					"patching_rect" : [ 212.0, 110.0, 135.0, 22.0 ],
					"style" : "",
					"text" : "route /x /y /z /speed /dir"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-183",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 184.0, 207.0, 74.399994, 22.0 ],
					"style" : "",
					"text" : "490.613983"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-181",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 69.5, 207.0, 86.0, 22.0 ],
					"style" : "",
					"text" : "601.866516"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-159",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 155.5, 233.0, 68.0, 22.0 ],
					"style" : "",
					"text" : "send udpY"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-158",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 34.5, 233.0, 68.0, 22.0 ],
					"style" : "",
					"text" : "send udpX"
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-156",
					"maxclass" : "newobj",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 212.0, 62.0, 69.0, 22.0 ],
					"style" : "",
					"text" : "udpreceive"
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"destination" : [ "obj-12", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-10", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-156", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-11", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-17", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-12", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-18", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 785.5, 192.0, 624.0, 192.0, 624.0, 309.0, 607.5, 309.0 ],
					"source" : [ "obj-12", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-5", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-13", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-20", 1 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-15", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-14", 1 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-156", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-184", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-156", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-5", 1 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-16", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-13", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-17", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-16", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-17", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-156", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-176", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-5", 1 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 607.5, 486.0, 838.0, 486.0 ],
					"source" : [ "obj-18", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-5", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 607.5, 486.0, 721.0, 486.0 ],
					"source" : [ "obj-18", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-1", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 291.1, 192.0, 348.0, 192.0, 348.0, 225.0, 348.899994, 225.0 ],
					"source" : [ "obj-184", 3 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-157", 1 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 267.9, 192.0, 337.5, 192.0 ],
					"source" : [ "obj-184", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-158", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 221.5, 192.0, 44.0, 192.0 ],
					"source" : [ "obj-184", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-159", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 244.7, 192.0, 165.0, 192.0, 165.0, 228.0, 165.0, 228.0 ],
					"source" : [ "obj-184", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-181", 1 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 221.5, 192.0, 146.0, 192.0 ],
					"source" : [ "obj-184", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-183", 1 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 244.7, 192.0, 248.899994, 192.0 ],
					"source" : [ "obj-184", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-2", 1 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 291.1, 192.0, 403.899994, 192.0 ],
					"source" : [ "obj-184", 3 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 314.3, 192.0, 453.0, 192.0, 453.0, 225.0, 453.899994, 225.0 ],
					"source" : [ "obj-184", 4 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-4", 1 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 314.3, 192.0, 501.899994, 192.0 ],
					"source" : [ "obj-184", 4 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-6", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 267.9, 132.0, 267.899994, 132.0 ],
					"source" : [ "obj-184", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-8", 1 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-20", 3 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-8", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-20", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-8", 2 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-20", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-8", 2 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-20", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-15", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-5", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-9", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-5", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-20", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-9", 0 ]
				}

			}
 ],
		"parameters" : 		{
			"obj-17::obj-51.16::obj-29" : [ "live.gain~[32]", "live.gain~", 0 ],
			"obj-17::obj-51.7::obj-19" : [ "live.gain~[14]", "live.gain~", 0 ],
			"obj-17::obj-51.19::obj-19" : [ "live.gain~[39]", "live.gain~", 0 ],
			"obj-17::obj-51.10::obj-29" : [ "live.gain~[21]", "live.gain~", 0 ],
			"obj-17::obj-51.21::obj-29" : [ "live.gain~[42]", "live.gain~", 0 ],
			"obj-17::obj-51.12::obj-29" : [ "live.gain~[24]", "live.gain~", 0 ],
			"obj-17::obj-51.3::obj-19" : [ "live.gain~[6]", "live.gain~", 0 ],
			"obj-17::obj-51.24::obj-19" : [ "live.gain~[49]", "live.gain~", 0 ],
			"obj-17::obj-51.15::obj-29" : [ "live.gain~[31]", "live.gain~", 0 ],
			"obj-17::obj-51.6::obj-19" : [ "live.gain~[13]", "live.gain~", 0 ],
			"obj-17::obj-51.17::obj-19" : [ "live.gain~[34]", "live.gain~", 0 ],
			"obj-17::obj-51.8::obj-19" : [ "live.gain~[16]", "live.gain~", 0 ],
			"obj-17::obj-51.20::obj-19" : [ "live.gain~[41]", "live.gain~", 0 ],
			"obj-17::obj-51.11::obj-29" : [ "live.gain~[23]", "live.gain~", 0 ],
			"obj-17::obj-51.2::obj-19" : [ "live.gain~[5]", "live.gain~", 0 ],
			"obj-17::obj-51.22::obj-29" : [ "live.gain~[44]", "live.gain~", 0 ],
			"obj-17::obj-51.13::obj-29" : [ "live.gain~[26]", "live.gain~", 0 ],
			"obj-17::obj-51.4::obj-19" : [ "live.gain~[8]", "live.gain~", 0 ],
			"obj-17::obj-13" : [ "live.step", "live.step", 0 ],
			"obj-17::obj-51.25::obj-19" : [ "live.gain~[51]", "live.gain~", 0 ],
			"obj-17::obj-51.16::obj-19" : [ "live.gain~[33]", "live.gain~", 0 ],
			"obj-17::obj-51.7::obj-29" : [ "live.gain~[15]", "live.gain~", 0 ],
			"obj-17::obj-51.18::obj-19" : [ "live.gain~[36]", "live.gain~", 0 ],
			"obj-17::obj-52" : [ "live.gain~", "live.gain~", 0 ],
			"obj-17::obj-51.1::obj-19" : [ "live.gain~[2]", "live.gain~", 0 ],
			"obj-17::obj-51.9::obj-19" : [ "live.gain~[18]", "live.gain~", 0 ],
			"obj-17::obj-51.21::obj-19" : [ "live.gain~[43]", "live.gain~", 0 ],
			"obj-17::obj-51.12::obj-19" : [ "live.gain~[25]", "live.gain~", 0 ],
			"obj-17::obj-51.3::obj-29" : [ "live.gain~[7]", "live.gain~", 0 ],
			"obj-17::obj-51.23::obj-29" : [ "live.gain~[46]", "live.gain~", 0 ],
			"obj-17::obj-57" : [ "live.gain~[55]", "live.gain~[54]", 0 ],
			"obj-17::obj-51.14::obj-29" : [ "live.gain~[28]", "live.gain~", 0 ],
			"obj-17::obj-51.5::obj-19" : [ "live.gain~[10]", "live.gain~", 0 ],
			"obj-17::obj-51.17::obj-29" : [ "live.gain~[35]", "live.gain~", 0 ],
			"obj-17::obj-51.8::obj-29" : [ "live.gain~[17]", "live.gain~", 0 ],
			"obj-17::obj-51.19::obj-29" : [ "live.gain~[38]", "live.gain~", 0 ],
			"obj-17::obj-51.10::obj-19" : [ "live.gain~[20]", "live.gain~", 0 ],
			"obj-17::obj-10" : [ "live.gain~[53]", "live.gain~", 0 ],
			"obj-17::obj-51.22::obj-19" : [ "live.gain~[45]", "live.gain~", 0 ],
			"obj-17::obj-51.13::obj-19" : [ "live.gain~[27]", "live.gain~", 0 ],
			"obj-17::obj-51.1::obj-29" : [ "live.gain~[3]", "live.gain~", 0 ],
			"obj-17::obj-51.4::obj-29" : [ "live.gain~[9]", "live.gain~", 0 ],
			"obj-17::obj-51.24::obj-29" : [ "live.gain~[48]", "live.gain~", 0 ],
			"obj-17::obj-51.15::obj-19" : [ "live.gain~[30]", "live.gain~", 0 ],
			"obj-17::obj-51.6::obj-29" : [ "live.gain~[12]", "live.gain~", 0 ],
			"obj-17::obj-51.18::obj-29" : [ "live.gain~[37]", "live.gain~", 0 ],
			"obj-17::obj-51.9::obj-29" : [ "live.gain~[19]", "live.gain~", 0 ],
			"obj-17::obj-51.20::obj-29" : [ "live.gain~[40]", "live.gain~", 0 ],
			"obj-5" : [ "live.gain~[56]", "live.gain~[56]", 0 ],
			"obj-17::obj-51.11::obj-19" : [ "live.gain~[22]", "live.gain~", 0 ],
			"obj-17::obj-51.2::obj-29" : [ "live.gain~[4]", "live.gain~", 0 ],
			"obj-17::obj-51.23::obj-19" : [ "live.gain~[47]", "live.gain~", 0 ],
			"obj-17::obj-55" : [ "live.gain~[54]", "live.gain~[54]", 0 ],
			"obj-17::obj-51.14::obj-19" : [ "live.gain~[29]", "live.gain~", 0 ],
			"obj-17::obj-51.5::obj-29" : [ "live.gain~[11]", "live.gain~", 0 ],
			"obj-17::obj-51.25::obj-29" : [ "live.gain~[50]", "live.gain~", 0 ],
			"obj-17::obj-49" : [ "live.toggle", "live.toggle", 0 ]
		}
,
		"dependency_cache" : [ 			{
				"name" : "automate2.maxpat",
				"bootpath" : "~/Desktop/Projet Final_EDM4610/github/anakronysm/Max",
				"patcherrelativepath" : ".",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "polyChords.maxpat",
				"bootpath" : "~/Desktop/Projet Final_EDM4610/github/anakronysm/Max",
				"patcherrelativepath" : ".",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "yafr2.maxpat",
				"bootpath" : "/Users/Shared/Max 7/Examples/effects/reverb/lib",
				"patcherrelativepath" : "../../../../../../Shared/Max 7/Examples/effects/reverb/lib",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "OSCswitch.maxpat",
				"bootpath" : "~/Desktop/Projet Final_EDM4610/github/anakronysm/Max",
				"patcherrelativepath" : ".",
				"type" : "JSON",
				"implicit" : 1
			}
 ],
		"embedsnapshot" : 0
	}

}
