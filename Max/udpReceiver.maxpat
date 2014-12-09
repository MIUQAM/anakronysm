{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 6,
			"minor" : 1,
			"revision" : 8,
			"architecture" : "x86"
		}
,
		"rect" : [ 222.0, 253.0, 840.0, 955.0 ],
		"bglocked" : 0,
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 0,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 0,
		"statusbarvisible" : 2,
		"toolbarvisible" : 1,
		"boxanimatetime" : 200,
		"imprint" : 0,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"devicewidth" : 0.0,
		"description" : "",
		"digest" : "",
		"tags" : "",
		"boxes" : [ 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-11",
					"maxclass" : "message",
					"numinlets" : 2,
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"patching_rect" : [ 348.0, 120.0, 68.0, 18.0 ],
					"text" : "port 12345"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-16",
					"maxclass" : "bpatcher",
					"name" : "automate.maxpat",
					"numinlets" : 1,
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"patching_rect" : [ 763.0, 268.0, 233.0, 230.0 ]
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
					"patching_rect" : [ 134.0, 134.0, 50.0, 31.0 ],
					"text" : "/speed -0."
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"id" : "obj-12",
					"maxclass" : "flonum",
					"maximum" : 2.5,
					"minimum" : 0.0,
					"numinlets" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "float", "bang" ],
					"parameter_enable" : 0,
					"patching_rect" : [ 930.0, 219.0, 50.0, 20.0 ]
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
					"patching_rect" : [ 776.0, 171.0, 107.0, 20.0 ],
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
					"patching_rect" : [ 776.0, 540.0, 66.0, 20.0 ],
					"text" : "clip~ -1. 1."
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-8",
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"numoutlets" : 0,
					"patching_rect" : [ 776.0, 627.0, 45.0, 45.0 ]
				}

			}
, 			{
				"box" : 				{
					"fontname" : "Arial",
					"fontsize" : 12.0,
					"frgb" : 0.0,
					"id" : "obj-7",
					"maxclass" : "comment",
					"numinlets" : 1,
					"numoutlets" : 0,
					"patching_rect" : [ 464.399994, 204.0, 150.0, 20.0 ],
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
					"patching_rect" : [ 447.399994, 278.0, 75.0, 20.0 ],
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
					"patching_rect" : [ 464.399994, 252.0, 50.0, 18.0 ],
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
					"patching_rect" : [ 342.399994, 278.0, 95.0, 20.0 ],
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
					"patching_rect" : [ 366.399994, 252.0, 50.0, 18.0 ],
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
					"patching_rect" : [ 261.399994, 278.0, 67.0, 20.0 ],
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
					"patching_rect" : [ 215.0, 61.0, 123.0, 20.0 ],
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
					"patching_rect" : [ 278.399994, 252.0, 71.600006, 18.0 ],
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
					"patching_rect" : [ 215.0, 155.0, 135.0, 20.0 ],
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
					"patching_rect" : [ 187.0, 252.0, 74.399994, 18.0 ],
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
					"patching_rect" : [ 72.5, 252.0, 86.0, 18.0 ],
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
					"patching_rect" : [ 158.5, 278.0, 68.0, 20.0 ],
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
					"patching_rect" : [ 37.5, 278.0, 68.0, 20.0 ],
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
					"patching_rect" : [ 215.0, 107.0, 69.0, 20.0 ],
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
					"destination" : [ "obj-16", 0 ],
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
					"destination" : [ "obj-9", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-16", 0 ]
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
					"destination" : [ "obj-1", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 294.100006, 237.0, 351.0, 237.0, 351.0, 270.0, 351.899994, 270.0 ],
					"source" : [ "obj-184", 3 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-157", 1 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 270.899994, 237.0, 340.5, 237.0 ],
					"source" : [ "obj-184", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-158", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 224.5, 237.0, 47.0, 237.0 ],
					"source" : [ "obj-184", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-159", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 247.699997, 237.0, 168.0, 237.0, 168.0, 273.0, 168.0, 273.0 ],
					"source" : [ "obj-184", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-181", 1 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 224.5, 237.0, 149.0, 237.0 ],
					"source" : [ "obj-184", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-183", 1 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 247.699997, 237.0, 251.899994, 237.0 ],
					"source" : [ "obj-184", 1 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-2", 1 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 294.100006, 237.0, 406.899994, 237.0 ],
					"source" : [ "obj-184", 3 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-3", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 317.299988, 237.0, 456.0, 237.0, 456.0, 270.0, 456.899994, 270.0 ],
					"source" : [ "obj-184", 4 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-4", 1 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 317.299988, 237.0, 504.899994, 237.0 ],
					"source" : [ "obj-184", 4 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-6", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"midpoints" : [ 270.899994, 177.0, 270.899994, 177.0 ],
					"source" : [ "obj-184", 2 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-8", 1 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-9", 0 ]
				}

			}
, 			{
				"patchline" : 				{
					"destination" : [ "obj-8", 0 ],
					"disabled" : 0,
					"hidden" : 0,
					"source" : [ "obj-9", 0 ]
				}

			}
 ],
		"parameters" : 		{
			"obj-16::obj-51.16::obj-29" : [ "live.gain~[32]", "live.gain~", 0 ],
			"obj-16::obj-51.18::obj-29" : [ "live.gain~[36]", "live.gain~", 0 ],
			"obj-16::obj-51.21::obj-29" : [ "live.gain~[42]", "live.gain~", 0 ],
			"obj-16::obj-51.13::obj-19" : [ "live.gain~[27]", "live.gain~", 0 ],
			"obj-16::obj-51.3::obj-29" : [ "live.gain~[6]", "live.gain~", 0 ],
			"obj-16::obj-51.25::obj-19" : [ "live.gain~[49]", "live.gain~", 0 ],
			"obj-16::obj-51.6::obj-29" : [ "live.gain~[12]", "live.gain~", 0 ],
			"obj-16::obj-51.8::obj-19" : [ "live.gain~[17]", "live.gain~", 0 ],
			"obj-16::obj-51.11::obj-29" : [ "live.gain~[22]", "live.gain~", 0 ],
			"obj-16::obj-51.15::obj-29" : [ "live.gain~[30]", "live.gain~", 0 ],
			"obj-16::obj-51.17::obj-19" : [ "live.gain~[35]", "live.gain~", 0 ],
			"obj-16::obj-51.19::obj-19" : [ "live.gain~[39]", "live.gain~", 0 ],
			"obj-16::obj-34" : [ "live.gain~[1]", "live.gain~", 0 ],
			"obj-16::obj-51.22::obj-29" : [ "live.gain~[44]", "live.gain~", 0 ],
			"obj-16::obj-51.3::obj-19" : [ "live.gain~[7]", "live.gain~", 0 ],
			"obj-16::obj-51.24::obj-19" : [ "live.gain~[48]", "live.gain~", 0 ],
			"obj-16::obj-51.5::obj-19" : [ "live.gain~[11]", "live.gain~", 0 ],
			"obj-16::obj-51.8::obj-29" : [ "live.gain~[16]", "live.gain~", 0 ],
			"obj-16::obj-51.10::obj-19" : [ "live.gain~[21]", "live.gain~", 0 ],
			"obj-16::obj-57" : [ "live.gain~[55]", "live.gain~[54]", 0 ],
			"obj-16::obj-51.14::obj-19" : [ "live.gain~[29]", "live.gain~", 0 ],
			"obj-16::obj-51.17::obj-29" : [ "live.gain~[34]", "live.gain~", 0 ],
			"obj-16::obj-51.20::obj-29" : [ "live.gain~[40]", "live.gain~", 0 ],
			"obj-16::obj-51.13::obj-29" : [ "live.gain~[26]", "live.gain~", 0 ],
			"obj-16::obj-10" : [ "live.gain~[53]", "live.gain~", 0 ],
			"obj-16::obj-51.24::obj-29" : [ "live.gain~[47]", "live.gain~", 0 ],
			"obj-16::obj-51.5::obj-29" : [ "live.gain~[10]", "live.gain~", 0 ],
			"obj-16::obj-51.25::obj-29" : [ "live.gain~[57]", "live.gain~", 0 ],
			"obj-16::obj-51.7::obj-19" : [ "live.gain~[15]", "live.gain~", 0 ],
			"obj-16::obj-51.2::obj-29" : [ "live.gain~[4]", "live.gain~", 0 ],
			"obj-16::obj-51.10::obj-29" : [ "live.gain~[20]", "live.gain~", 0 ],
			"obj-16::obj-55" : [ "live.gain~[54]", "live.gain~[54]", 0 ],
			"obj-16::obj-51.12::obj-29" : [ "live.gain~[24]", "live.gain~", 0 ],
			"obj-16::obj-51.16::obj-19" : [ "live.gain~[33]", "live.gain~", 0 ],
			"obj-16::obj-51.14::obj-29" : [ "live.gain~[28]", "live.gain~", 0 ],
			"obj-16::obj-51.19::obj-29" : [ "live.gain~[38]", "live.gain~", 0 ],
			"obj-16::obj-51.21::obj-19" : [ "live.gain~[43]", "live.gain~", 0 ],
			"obj-16::obj-52" : [ "live.gain~", "live.gain~", 0 ],
			"obj-16::obj-51.1::obj-29" : [ "live.gain~[3]", "live.gain~", 0 ],
			"obj-16::obj-51.2::obj-19" : [ "live.gain~[5]", "live.gain~", 0 ],
			"obj-16::obj-51.23::obj-19" : [ "live.gain~[46]", "live.gain~", 0 ],
			"obj-16::obj-51.4::obj-19" : [ "live.gain~[9]", "live.gain~", 0 ],
			"obj-16::obj-51.23::obj-29" : [ "live.gain~[56]", "live.gain~", 0 ],
			"obj-16::obj-51.7::obj-29" : [ "live.gain~[14]", "live.gain~", 0 ],
			"obj-16::obj-51.9::obj-29" : [ "live.gain~[18]", "live.gain~", 0 ],
			"obj-16::obj-51.12::obj-19" : [ "live.gain~[25]", "live.gain~", 0 ],
			"obj-16::obj-51.15::obj-19" : [ "live.gain~[31]", "live.gain~", 0 ],
			"obj-16::obj-51.18::obj-19" : [ "live.gain~[37]", "live.gain~", 0 ],
			"obj-16::obj-51.20::obj-19" : [ "live.gain~[41]", "live.gain~", 0 ],
			"obj-16::obj-51.1::obj-19" : [ "live.gain~[2]", "live.gain~", 0 ],
			"obj-16::obj-51.22::obj-19" : [ "live.gain~[45]", "live.gain~", 0 ],
			"obj-16::obj-51.4::obj-29" : [ "live.gain~[8]", "live.gain~", 0 ],
			"obj-16::obj-51.6::obj-19" : [ "live.gain~[13]", "live.gain~", 0 ],
			"obj-16::obj-51.9::obj-19" : [ "live.gain~[19]", "live.gain~", 0 ],
			"obj-16::obj-51.11::obj-19" : [ "live.gain~[23]", "live.gain~", 0 ]
		}
,
		"dependency_cache" : [ 			{
				"name" : "automate.maxpat",
				"bootpath" : "/Users/marcantoinebrodeur/Dropbox/UQAM/Session 3/EDM4610/TP_Final/anakronysm/Max",
				"patcherrelativepath" : ".",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "polyChords.maxpat",
				"bootpath" : "/Users/marcantoinebrodeur/Dropbox/UQAM/Session 3/EDM4610/TP_Final/anakronysm/Max",
				"patcherrelativepath" : ".",
				"type" : "JSON",
				"implicit" : 1
			}
 ]
	}

}
