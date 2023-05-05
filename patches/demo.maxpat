{
	"patcher" : 	{
		"fileversion" : 1,
		"appversion" : 		{
			"major" : 8,
			"minor" : 5,
			"revision" : 0,
			"architecture" : "x64",
			"modernui" : 1
		}
,
		"classnamespace" : "box",
		"rect" : [ 202.0, 103.0, 1306.0, 773.0 ],
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
		"showontab" : 1,
		"assistshowspatchername" : 0,
		"boxes" : [ 			{
				"box" : 				{
					"id" : "obj-2",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 8,
							"minor" : 5,
							"revision" : 0,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"classnamespace" : "box",
						"rect" : [ 0.0, 26.0, 1306.0, 721.0 ],
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
						"showontab" : 1,
						"assistshowspatchername" : 0,
						"boxes" : [ 							{
								"box" : 								{
									"autofit" : 1,
									"forceaspect" : 1,
									"id" : "obj-7",
									"maxclass" : "fpic",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "jit_matrix" ],
									"patching_rect" : [ 144.633346557617188, 27.995015737360177, 130.0, 37.936363636363637 ],
									"pic" : "/Users/domkirke/Dropbox/code/vschaos2/assets/logo.png"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-59",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 118.428571428571445, 108.133331298828125, 150.0, 20.0 ],
									"text" : "reset"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-48",
									"linecount" : 5,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 945.0, 186.79998779296875, 233.5, 74.0 ],
									"text" : "phase reconstruction method can also be set.\n- random : random phase\n- pghi : phase gradient heap integration\n- sinebank : fixed phase sine bank"
								}

							}
, 							{
								"box" : 								{
									"fontface" : 1,
									"fontsize" : 20.0,
									"id" : "obj-49",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 945.0, 155.79998779296875, 189.0, 29.0 ],
									"text" : "Inversion mode"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-45",
									"items" : [ "random", ",", "sinebank", ",", "pghi" ],
									"maxclass" : "umenu",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "int", "", "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 1065.0, 281.0, 100.0, 22.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-46",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1065.0, 316.0, 129.0, 22.0 ],
									"text" : "set inversion_mode $1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-43",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 945.0, 316.0, 113.0, 22.0 ],
									"text" : "get inversion_mode"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-42",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 93.133346557617188, 137.133331298828125, 35.0, 22.0 ],
									"text" : "5000"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-39",
									"maxclass" : "button",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 93.133346557617188, 106.133331298828125, 24.0, 24.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-37",
									"items" : [ "none", ",", "PCA", ",", "ICA" ],
									"maxclass" : "umenu",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "int", "", "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 815.0, 281.0, 100.0, 22.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-36",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 742.0, 501.0, 29.0, 22.0 ],
									"text" : "thru"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-35",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 815.0, 316.0, 81.0, 22.0 ],
									"text" : "set dimred $1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-34",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 742.0, 316.0, 65.0, 22.0 ],
									"text" : "get dimred"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-31",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 134.428571428571445, 137.133331298828125, 90.0, 22.0 ],
									"text" : "loadmess 5000"
								}

							}
, 							{
								"box" : 								{
									"fontface" : 0,
									"fontname" : "Arial",
									"fontsize" : 12.0,
									"id" : "obj-29",
									"maxclass" : "number~",
									"mode" : 1,
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "signal", "float" ],
									"patching_rect" : [ 634.000000000000114, 327.0, 56.0, 22.0 ],
									"sig" : 0.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-30",
									"maxclass" : "slider",
									"min" : -5.0,
									"mult" : 0.001,
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 634.000000000000114, 166.800003051757812, 20.0, 140.0 ],
									"size" : 10000.0
								}

							}
, 							{
								"box" : 								{
									"fontface" : 0,
									"fontname" : "Arial",
									"fontsize" : 12.0,
									"id" : "obj-27",
									"maxclass" : "number~",
									"mode" : 1,
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "signal", "float" ],
									"patching_rect" : [ 557.428571428571445, 327.0, 56.0, 22.0 ],
									"sig" : 0.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-28",
									"maxclass" : "slider",
									"min" : -5.0,
									"mult" : 0.001,
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 557.428571428571445, 166.800003051757812, 20.0, 140.0 ],
									"size" : 10000.0
								}

							}
, 							{
								"box" : 								{
									"fontface" : 0,
									"fontname" : "Arial",
									"fontsize" : 12.0,
									"id" : "obj-25",
									"maxclass" : "number~",
									"mode" : 1,
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "signal", "float" ],
									"patching_rect" : [ 479.428571428571445, 327.0, 56.0, 22.0 ],
									"sig" : 0.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-26",
									"maxclass" : "slider",
									"min" : -5.0,
									"mult" : 0.001,
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 479.428571428571445, 166.800003051757812, 20.0, 140.0 ],
									"size" : 10000.0
								}

							}
, 							{
								"box" : 								{
									"fontface" : 0,
									"fontname" : "Arial",
									"fontsize" : 12.0,
									"id" : "obj-22",
									"maxclass" : "number~",
									"mode" : 1,
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "signal", "float" ],
									"patching_rect" : [ 402.428571428571445, 327.0, 56.0, 22.0 ],
									"sig" : 0.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-24",
									"maxclass" : "slider",
									"min" : -5.0,
									"mult" : 0.001,
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 402.428571428571445, 166.800003051757812, 20.0, 140.0 ],
									"size" : 10000.0
								}

							}
, 							{
								"box" : 								{
									"fontface" : 0,
									"fontname" : "Arial",
									"fontsize" : 12.0,
									"id" : "obj-20",
									"maxclass" : "number~",
									"mode" : 1,
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "signal", "float" ],
									"patching_rect" : [ 324.428571428571445, 327.0, 56.0, 22.0 ],
									"sig" : 0.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-21",
									"maxclass" : "slider",
									"min" : -5.0,
									"mult" : 0.001,
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 324.428571428571445, 166.800003051757812, 20.0, 140.0 ],
									"size" : 10000.0
								}

							}
, 							{
								"box" : 								{
									"fontface" : 0,
									"fontname" : "Arial",
									"fontsize" : 12.0,
									"id" : "obj-18",
									"maxclass" : "number~",
									"mode" : 1,
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "signal", "float" ],
									"patching_rect" : [ 247.428571428571445, 327.0, 56.0, 22.0 ],
									"sig" : 0.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-19",
									"maxclass" : "slider",
									"min" : -5.0,
									"mult" : 0.001,
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 247.428571428571445, 166.800003051757812, 20.0, 140.0 ],
									"size" : 10000.0
								}

							}
, 							{
								"box" : 								{
									"fontface" : 0,
									"fontname" : "Arial",
									"fontsize" : 12.0,
									"id" : "obj-13",
									"maxclass" : "number~",
									"mode" : 1,
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "signal", "float" ],
									"patching_rect" : [ 169.428571428571445, 327.0, 56.0, 22.0 ],
									"sig" : 0.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-17",
									"maxclass" : "slider",
									"min" : -5.0,
									"mult" : 0.001,
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 169.428571428571445, 166.800003051757812, 20.0, 140.0 ],
									"size" : 10000.0
								}

							}
, 							{
								"box" : 								{
									"fontface" : 0,
									"fontname" : "Arial",
									"fontsize" : 12.0,
									"id" : "obj-9",
									"maxclass" : "number~",
									"mode" : 1,
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "signal", "float" ],
									"patching_rect" : [ 92.0, 327.0, 56.0, 22.0 ],
									"sig" : 0.0
								}

							}
, 							{
								"box" : 								{
									"floatoutput" : 1,
									"id" : "obj-1",
									"maxclass" : "slider",
									"min" : -5.0,
									"mult" : 0.001,
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 92.0, 166.800003051757812, 20.0, 140.0 ],
									"size" : 10000.0
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-23",
									"maxclass" : "newobj",
									"numinlets" : 8,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 92.000000000000114, 552.60003662109375, 561.0, 22.0 ],
									"text" : "nn~ ordinario decode 2048"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-8",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1210.4000244140625, 112.133331298828125, 29.5, 22.0 ],
									"text" : "120"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-6",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1210.4000244140625, 84.0, 44.0, 22.0 ],
									"text" : "launch"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-75",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"patching_rect" : [ 1148.0, 47.200000762939453, 34.0, 22.0 ],
									"text" : "sel 0"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-74",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"patching_rect" : [ 1148.0, 5.600000381469727, 40.0, 22.0 ],
									"text" : "active"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-73",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1148.0, 112.133331298828125, 30.5, 22.0 ],
									"text" : "0"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-71",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1148.0, 82.400001525878906, 35.0, 22.0 ],
									"text" : "clear"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-16",
									"linecount" : 6,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 741.0, 186.79998779296875, 165.199996948242188, 87.0 ],
									"text" : "Latent projection can be set using the dimred attribute. \n- none : no latent projection\n- PCA : maximum variance projection, sorted in importance order."
								}

							}
, 							{
								"box" : 								{
									"fontface" : 1,
									"fontsize" : 20.0,
									"id" : "obj-4",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 741.0, 155.79998779296875, 150.0, 29.0 ],
									"text" : "Projection"
								}

							}
, 							{
								"box" : 								{
									"fontsize" : 16.0,
									"id" : "obj-2",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 296.933349609375, 55.918949127197266, 665.0, 24.0 ],
									"text" : "vschaos can be used for spectral generation, as a synthesizer. "
								}

							}
, 							{
								"box" : 								{
									"fontface" : 1,
									"fontsize" : 30.0,
									"id" : "obj-3",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 296.933349609375, 14.007445335388184, 665.0, 40.0 ],
									"text" : "quickstart"
								}

							}
, 							{
								"box" : 								{
									"autofit" : 1,
									"forceaspect" : 1,
									"id" : "obj-79",
									"maxclass" : "fpic",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "jit_matrix" ],
									"patching_rect" : [ 1102.166748046875, 674.976806640625, 158.26666259765625, 46.863375418526786 ],
									"pic" : "logoircam_noir.png"
								}

							}
, 							{
								"box" : 								{
									"autofit" : 1,
									"data" : [ 8126, "png", "IBkSG0fBZn....PCIgDQRA..APO..D.BHX....PpFZ.5....DLmPIQEBHf.B7g.YHB..eTWRDEDU3wY6cuG+kTWWGG+0ue6E32hvBHWzX2kRAVPItlkxMyRhKlQp.pUVf30REUP7FHjWRDDwn7FZpkJpDgIfZZdAHLQ4VXDfjJKTJKnrrKBHK6s9iu6IVVNyuemKyLe+Ly754iGe+CQX98cly464y4Lym48LAv7QsA6AvoCreav+reBvaC3BAVWNlTRsbSB7h.dh.uWf6MuSG0kMAVPuoaa.NYRenxrJ3emqD3MBb800jRpCX+H8kn2i0++9mA7N.9z.qMWSJ0cYA8lq4.7RIUndPdMbsj9fl2AoO3QRilE.71AdtE7++0C7l.9N01LRhGcA8UCrpLMWzf6P.NSfEOB+2tBf+JfO.9ZszvXJfSD30CLuY3e20A7OB7V.9ep34kDj9QdL+MXroYc5nYxt.bIj9vhwcby.Gd8N8kZjl.3E.baL7qytefSkY9K.HMtlBrfdSv7I0vMqjxoX9FN9xLZ+Reotf8A3xY7Wmca.O+ZdtqtEKnGbSB7R.VJkeg7Mb7P.mE1OER8rc.eTf0P4tV6x.16Zb+PcGVPOvN.fqgpsP9FOtSRMZ2j0v9mTDMWRWi7kS0sNa0.mKouzfTYwB5AzBA9rj5J85rX9FNtVfCrp2QkBlCmTukTWqytGfWGquYljFSVPOPlhTHvb+juB4a3Xs.eNfEUk6zRAvhI0KI4Zs1MAbXU9doZ6rfdPbz.Kg7WDueC6RW0VMeR8NxCQ9WmsNR2AK6RktGq1LKnmY6EoljI2ePxfL50ktSTIGIjpOSRpWQtSx+5pMdrRR2QK1fpZXYA8LYaA9HjZNlb+AHC63xwtzUMWGHodDI2qilowcR5NbwFTUCJKnWylColf4dH+efw3LVC1ktpYYQj5Ijb1roix3ZHcGuHMSrfdM5PI07K49CHJywxIcK9XW5pnZd.mFwoYSGkwZIcmurvx8PiZYrfdMnLiq0nNtYrKcUrLAod9XThq0nN50fpSUhGmT6gEzqPUYbsF0wWBiQVke6MkSbsF0wRHcmwHsgrfdEXRfiipOtVi5vtzU4x1Qp2NJ63ZMpCiQVsgrfdI6..tZx+B8HLrKcUcYNT8w0ZTGqlzcLy1N1GEUSmEzKIKD37n40As0wvtzUUo5NtVi5vXjUVPeLEs3ZMpC6RWU1VLod1H2u2NZCiQ1tKKnOFhbbsF0gcoqFWQKtVi5vXjs6wB5ifnGWqKA3cAboAXtLcyQ6RWMLljTOYDw3ZMpCaP0tEKnODhdbsd+jN8+a3u98n.t0.L2JZXW5pAwARpWLx86WKZrZfUEf4QQikR5NuwFTscyB5CfnGWqyz0mdJfSA39BvbsnOLztzU8yhH8d6n1ro2CvqkGtQzhdZPd0XCp1lYA8YPzWfNLcP9B.9LD6ObztzUPJtVOUhayltZfOL8+Kg1D9A.mG1fpsQVPu.QOtVWJi98389SruW4sKc6tZBw05kBrmCv9RS7RzolMKnuQlOvYRbiq0xpIWlD3ESrSyN6R2tknGWq2JodRYX0DZhVaP01AKnudMg3ZsJJvsEzM9BLJthdbsdej5Akw8WxF8ay0KizW9PMWVPm3GWq0wofdmAt3.ruVzvtzs8I5w05ZI0yIKnD2midPTYCp1r0oKnG83ZMGMIVzaBP6R21gCiXGWqWModMop3m8npPmrfteK4o2bHcq3XW5pxVziq0kRp2RpqyDzAPru+5uIReIe0Lz4JneTD+qiUTBZE6RWUVlOodgHx8pwYRpmRpac092QkuNSA88BiB0QkG6znpIDWqWLodHI27K8nwUqufdS3WYdpzL9UlQ+raboXW5FIQOtVuQh4oStIjAF1fpwTqsfdS35.2DebhZ+GnYRSKtVipCi32fpUYiCpgWqrfdz6T6gItViplPW51D9P61jon4FWqQkwHqFFspB56Bw9do9NYziq0npIbO7GwSqZaSSHtVaxWNllvkNzFTM+ZEEzMsyxqlPW5FkFepsYuI9wZ5nDWqQkGu0zoQWPuITHoKc6dXW51czKtV8WLlGQOFYuTZ1mQjlpFaAcehgEWMgtzsNCOj1Dultwg8rf1XMtB5MglwxHSLwtzscwWOioEh2UAJowTPuIb6RctjNUj5g0D9Eck8Cfi1llvYbw6K53GirQ899uMoQTPO5AZRjhq0nJ5coaY8HxrMwdhn4wj4qaKzEzidjidajtcczfK5co6shcoauhBQtYSuX5NMa5nvuLV2THKnusjZlhn9q45EWqyqpN.zAzD5R28rh12irneZaMWAFN9zsqaITEzaJw05hppC.cL1ktwgMVU6VW+4OeWQXJnenjZZhb+FqhFWCoG1Dp7E8hIKC33ocVLoI7kpLa9KGMkFTsKbKGVUxdA8cFiqUkD8S26MBbHU1de8qIbYOLbRJe8BEn0P9eMteCaP0QW1Jnabsp9oIzktWDM6tzcuH1Ml3Rvmu80gn2fpKAaP0gUsWPeRRMAQj6f1uDolIoMad.ecfmUtmHEnIzktmAMqtzM525fs83ZMhlflwCVmtXCpNJp0B5QOtVuY5Nw05owCue+U.10rNaJVz6R26f32ktMgqcZWItVip4Q76khtRCpNNpkB5KfTyND0ldZ4.udZmM8T+rPdzKbeHf2GvVlw40zI5co6UAreU1d+3YOHt+p7qlTuSnXXQD6FT061goWkVPeJRM2v8Q9eiP+FqgtYbsddT7wj6B3kALqrM6J1bH8EuVN4+8N8a7KHtegnyk7e7YCGFWqw1AhMnZSTkUPO5w05kS2LtV2eFru880AbPYZNNShZW5dxU4N8XZ6HFeQndIDlMaZ70DZPUiQ1GoRufdSItVmXL2OahljzoFdXNd84A1wbLYG.6MouXVteO05HEYrQuYtNAx6wnKAiq0ln4CbVXCp1DTZEzMtViuikQ6X2CPpI5h3wtnzktMgaul4BbKT+GaLtVaGhdCpZLxVBEzaBw05mCiq0MG3mx3cr71AdADyytQN6R2KqF1+JKOapuiK2Cotq2FXpc4vI9MnZWMFYGqB5GBFWqMEuaJuiq+a.6S8N8GXKhzWfqt5R20PyqWL9pTsGSLtVa+hdCp1KFYWPUc.HnFoB5FWqMKOAfGjxuP1Gk3dGBbf.WKU+609n00NTI5IArJpliGWFFWqcIQsAU6M5ZwH6PUPeKH07AQs4HdHRMugcP6izER0cLe4jZ1p4Va6MCtIAdoTcco6xIteglYx4P4drXIXbs1kEoFTseiaE3Hqr893XfJnabs1b86P8b7+lIcs0hndco6CQ4tOeh04NQIaqA94L9GCLtVUOQoAUmtw2h1cLxNiEz2eF9a0o5bD4BI41r.tdp2WO9xD2uX0hIM+Ji8yagXdVIFFuJF88+0RJQwLtV0FqoDiraSUc.HiJrftw0Zy2qf77ZSzuzGkQW59rq8Yc4a1.2.C+990fw0plY0cCpNrikAb7ztpg7nJnuUXbs1FrU.+Lx6qU2IoqgcDaNw4R5Z+OJco6WMCy2pxAyfueuTrYS0vqtZP0QczlhQ1GQA8+LLtVaKNax+qW8FWKw81Gb6H0o5CZW5tJfmbVloUmuHS+97JI8nrMpmwEEeUcCpVFiKhleLxNEjtN4WA4+.ZQitbbsNJ1UJ+F.abGQOfe1GR2e8yz9weStlfUnclhuyULtVUYppZP0xZzziQ1ofp6dRcbGFWqilWAFAuihIHkDd2N8ete2j5N71nyjG495MQ5QVqTUH5wH6cP5N6po8iHmBhWSKD8eMWSvdP5VzH2uVVzHxm0k4QJ65e.djy4WUFmSUs4S5Zjabsp5TziQ1n93PtHgqfdjudqMQGIoPUH2utVzHx8EwNR5oM25H0M3yNuSmJ2Ahw0ppeyk3FirVPeDGQtina5lhzypauyEFMGDc2G1CR0kgsAUsf9iV1KnG86Y41jE.7oIFeAt9MLaAjz9PbhQVKnODCiq07X+H9o+mMjkT2UuFTM2wHqEzGfgw0Z9MIvwRpaNycA7hF9E9j5150fp4JFYsf9zL5cJUa5YfcaRzeB5YnlHobEirVPuOin+ryVovE4hH+EvKZ3y3dIcPTuwHqEz2nwkSpIGTyvgPJaiycA7hF9fAQpaqNiQVKnu9wsQpoFhXvgno2bH8THZYj+B38a3itSIskT8wHqEzA9fDyn8TCmsgzyM3nGirSUUG.jT3sXfuLVPGpnB5dsxaW1ShcLxtDfitp14kTivQfEzsftFXGEwNFYuLhaLxJop0rwB5VPWCko.NEhaLxtZfOBlI4RcMVP2B5ZDs.fOCwMFY8oFlT2hEzsftFS6OvUS9KfWz3l.NzJauWRQgEzsftJASB7hI87zN2EvKZbI.6RUc.PRYmEzsftJQaAvYRriQ1yDiQVo1HKnaAcUA1YfKl7W.unwRANNLFYkZSrftEzUE5PIcMrycA7hFWMFirRsEVP2B5phMGfWKotNO2Ev623yVc65RpFYAcKnqZx1R59CORwH68S5wxnjZ9rftEzUMau.tTxew70AbZU5dpjpSVP2B5JSNZRYvdtJle63CPHo1DKnaAckQSA71Hcpuq6B5+Q0v9mjpOVP2B5J.VHv4Q8EireafIpk8LIUWrftEzUfb.T8wH6Z.dJ00NjjpMVP2B5JXljTnuTUwH6mn91UjTMxB5vTSPpfdYdJH2df6pD2dp6Y9jdLs9pAlaIsM+E.KF3NJos2vZ9.6aIt8d.fqrD2dRMYyFXUk71bq.VdIuMqRVPWg1t.79.dVkv15s.7tKgsynZ+AthRb68C.10Rb6I0j0TKn+bHcVIKCyB7Ttq36vX7hQ1eDvlV6y5Go8mxcc1MWuSeoPqodJ2OgxbN6CnB0D7U.1CfWOi12X9M.7fk5LRRJXhdA8iBXEk33KTuSeUhVEvYS5zvetj5X8Aw2B3BqpIkjTTL6bOAlAygzyY6xxlUhaKkG+LfWNvGF38CbPSy+tqgzCGFIoVun+KzkJx0A7zAd9jhx094iA78qsYjjTFYAc0zc9j516SizsxUOKmzs9ljTmfEzUavuD3uDX2.9bj53y2NoSOujTmPzuF5RCiaG3EBbNjhQVIoNCKnq1nuStm.RR0MOk6RRRs.VPWRRpEvB5RRRs.VPWRRpEvB5RRRs.VPWihGComRPdWRHIED9AxZXLAveLvoCrCjdfobNYcFIII.+E5Zv8T.91.eJREygTbq9Xy0DRRROLKnqYxiG3S.bk.OsM5+ushTDqJIoLyB5pHaBvaD3G.bLT76UdY.6dMMmjjTArft5m+.fafz0Jeymg+cmMvYW4yHIIMsrft1POIfuFvWDXmFh+6dl.GQkLijjz.wB5BRWK7+ZfqG3fGwsw6kzooWRRYfEz61lEvqD3V.dMLd2Fi6DvwWFSJIIM7rfd20y.3ZA9f.aSIsMeq.OtRZaIIogfEz6d9UAt.fuIvdTxa6s.3cUxaSIIM.rfd2wlA7N.tIfmWE924X.12Jb6KIo9vB5se8hq0aF3jA1zJ9u2j.u+0+2URR0DKn2t8a.bE.eZfETi+cO.fitF+6II04YA81oGGvGG36BreYZNbF.Sko+1RRcNVPucYt.uARw05wRde8cQqetHIoZfEzaOd1jhq0yfT2lGAmD06o5WRpyxB5Me6Fv+BvEAryYdtrw1Lf2btmDRRcAVPu4ZqH0M4WOvgj44R+7f.uaROw1jjTEabh5SkGyB3kP5dJeay7boHeAfSD3Gm6IhjTWgEzaVd5jdHprm4dhTfa.30B7Mx8DQRpqwS4dyvNBb9.WJwrX9cC7p.1arXtjTV3uPO11LRWC5SjXdOcuZfOBvaCXYYdtHI0oYA8XZBfW.v6AXgYdtTjuAoSu9Mj6IhjjrfdDsujtN46etmHE3GS5LF7Ex8DQRROLuF5ww1C7w.9dDyh42GvaA3IiEykjBG+E542bAdM.mBwIg21PqizC2k2DvOMyyEIIU.KnmWOKf2Gvtj6IRA9tjtN4WYtmHRRZ54obOO1UfuBvkPLKleG.GCvSCKlKI0HXA850VR5Wj+8ANzLOW5mUBb5.KF3umzoaWRRM.dJ2qGyB33.dmD23Z8KBbB.+nbOQjjzvyB5UuChzsg1dk6IRA9uHccx+54dhHIoQmmx8pyNB74AtLhYw7kQp652KrXtjTim+B8x27.No0OhXbstFd33Z8ty7bQRRkDKnWtdr.WKvhx8Do.eSRmd8+ybOQjjT4xS4d45tAttbOI5iaE34A76hEykjZkrfd46DHc6eEA2GvIC7j.tvLOWjjTExB5kueDotZOm5EWq6Jv6B3Ay6zQRRUMKnWMdW.KMS+suJRObWdQ.+jLMGjjTMyB5Ui6E3sVy+MWJvwB7TA9N07eaIIkYVPu57IAtlZ3uyJANCRYB+mDXs0veSIIELVPu5rVR2hXUYdneQ.6NvaD3WTg+cjjTvYA8p0U.b9Uv18FANDfi.3GVAaeII0vXA8p2IA7KKos08.b7.6IvWqj1lRRpEvB5UuaG3LGyswZ.9vjtN4mCvpG2IkjjZWrfd838.7+Nh+2do.6CvqD3mWVSHII0tXA85wCPpw0FFKA3n.dF.e+xdBIIo1EKnWe9r.+6Cv+d2Ovo.ra.WPkNijjTqgEzqOqizswVQ2m3qC3yPJtVemXbsJIogfEzqWWEvmpO+yuZfC.3OgQ+ZsKIoNLKnW+dyjdJnAo3Z83.9sXvNc7RRR80ry8DnC5N.NMfsmzoV+dy5rQRRsBVPOONqbOAjjT6hmxcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.SJNo5wcC7OUhaueZItsjTKfEzkpG2LvQl6IgjBkkB7cKos0jSP54y8DkzFDROzQtqRZasi.O0RZaAoCdWVIt8jjT9MafUUxaysBX4k71rJMUz+E5215GRRRZZXSwIII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BTEEzec.yoB1tRRR8SzetjTaVKv5J4wMAbX04Ngjj5jNXfe.kecrsrN2IJASAUSA8diKAXWpq8FII0YrS.+yTc0urfdeFqD38BL+5YeRRRsXaNvoC7fTs0trf9zLVJvwgMhmjjFdSBbL.+TpmZVVPe.FWCvATC6bRRpc3oA7codqUYA8AbrVfyCXgU9tnjjZp1AfOE4oNkEzGxw8C715MQjjj.1Tf2Bvuf7UexB5i3XI.GcktqJMXdt.+Z4dRjYaMviK2SB0Y8bA9wj+5RVPeLGWFvdUk6wRE3WG3aP58gWPlmK41GBXE.mDvby7bQcGa3ZvHLrfdILVMvGAXaqt8ao+eOVfO.o22sguO72NiyobZO3Qdr3V.d1YcFo1thVCl6Qirf9ZH+G3523dvXjUUmYC7pAta5+6+9O.lU1lc4SQ+BouJvtkw4kZelo0f4dzHKneH.WG4+fWQiaB3PqnC.pa5fAtAl4268xy0DLSdNL8GOdHf2OvVkqInZMdlLXqAy035H0XdMISAoDbaq.dU.2I4+.YQCiQVMtdhLbQE4cQy6aoOp1DfeDC1wkeFvqft4YvPimgcMXcOtKReQ9l36s++Kn2ar8.mIo3ZM2GX62Xkqe9sEUvAC0dMNQE4Ykg4aN7lX3O17eP2sWCzvYyAd2T8w05nNdHfyll8Wf+QUPu2oXXWH8Khy8A4hFFirZPLIveFiWTQtRfEW2S7Z1iG3dYzOF8OB7qV2SZ0HLAi+Zvpd7uP6n+PJrfdOGJoqgctOfWz3pA1+R5fgZWdpTdQE4kTyy851Gmw+XzC.7N.1rZdtq3pLWCVEiaA32ux16qeyXAcH0k4uNRccdteAneCiQVsg1Af+AJ+aGyCoN2IpQ+FTt2oK+O.+Qj9kYpa5WgpYMXYMVAvaf1WFKLPEz6YaIc+gGs6UvdCiQ1tspNpHuQZe2BkS.bETMGu91j9xBp6HBw05zMVCveGodEqMZnJn2ydQJQ2x8KNEMVBvQM7GKTCVcEUjul5ZGpl7Bod9.TiQ11umCC9cIQNFWAs+uf4HUPumilTwyb+BUQiKEiQ11t5NpHWFoTspMXd.2F0yws15o3TwKtV23QW5R.MVEz6sANURmt6b+BW+FqF3CiwHaaSunhbUT+um5CTC6e0gSk5+XmwHa6QNWCNHiG.3sS2pIMG6B58rPfOKwsIHtGfWKsuqAZWyrIE.R4LpHWEvtW06nUrERd+R3skaSntnHrFblFc0aixRqfdOG.v0P9eAsnwMR6saka6hTTQ9uVw6qUsyi7eLzXjs4IRqA62nqGzQkdAcHElGuDhcLxdw.6bIrupp2SD3KP9eOyFONhpbmtBseDqyjVSNpM6Jh5ZvdCih3jJofdOyG38RriQ1y.iQ1nJ5QE4MQyqQalD3pH+G652nq+qqhnnuFzyxyiTkVPumlPLx9hwXjMJLpHqNyh3e8OOe5lW+yHw0fMS0RA8dNLhcLxdUXLxlaMgnhrMzk11gxpHOUfqj7+df19ZvpPsVPGZFwH6mAXAU0A.0WFUj4g2CwpGWC17U6Ez6Y6.NWJ2LjtLG2GvofwHaUqoDUjs8jNqtRZuQcbE.6aks22sso.uYh8ZvONs+0fkgrUPum8lXGir2JvQVY68caQOpH6ZYQdS4KW0Vyg6bv0fsKYufNjNcZOepuXnbTFeKf8rpN.zw7qC70I+ulVznqeZdqpmVck0XE.mHdpWGG6NweM3eLc20fipPTPum4Q7iQ1ODv1TUG.Z4dr.+sD6Fwxmm2OrlPCJ1ldVVWGbMX6VnJn2yhH1wH6x.NdLFYGTFUjMWSR7u8k9J3suzLw0fcCgrfdOGHFirMcOSf+Sx+qUEMLLSFLaNvoSrCXjyFXKqpC.MX+t3ZvthPWPGZFwH6EgwH6Fynhrc5IB7OS9e8qngwH6C6IfqA6ZBeA8dlOvYQ5ahm62H1ugwHaxiAiJxtfClX+P535.d5U1der8X.9qv0fcQMlB58rXfuD4+MkEMtCfiktWLxNAveJvOg7+ZPQiuJvSppN.zAMafWMw95xd9.6XUc.HXbMnZbEz64vAtYx+aPKZbUjdpV0E7agQEYWVuXjc0j+Wq623A.9KIcWzzVE80f+23Zv5PisfNj5x7WOvxI+ugsei0B7oo8Fir+J.+8D26FgU.bR38qbcI5wH6sC7BoccuM6ZPsgZzEz6Y6.9nD6Xj8jo8DiraBFUjpXFirUOWCp9oUTPum8A3xI+uYtnwsRyOFYMpH0fXSAdqD6BNeLZlwH6eHweM3Sox160zoUUPGLFYqJFUjZTrC.eJh8oDtoDirtFTyjVWA8dlGvogwH63ZqI1QE4uDiJxlfmFv2i7+9khF+.haLxt0.+M3ZPMyZsEz6YQ.eNh6uPXY.uFR2BPQxrA9KH12RRFUjMKSBbLD+XjcWqn8+gUu0f+bx+wkhFW.tFLRZ8Ez64.AtVx+BfhF+W.+dU1d+vI5QE40iQEYSlwH6LqIrF7YTY68ZT0YJnCoegvKkXGireQfcppN.LCdB.W3.LGy0vnhrcYmH898b+9phF2EvKi588aMg0fuRbMXT0oJn2yVB79HtwH6CB7dn9hQ1nGUjqB3uFiJx1pClzYnJ2uOqnw0AbPU1deRu0f+xLuu5ZvlsNYA8dVLvWl7uXonQUGirFUjJJlModIYYj+2yUz3yS4GirtFTkoNcA8dNbRc4ZtW3Tz36QpKgKSMgnh7Onj2mU7sM.eP5FwHqqAUYyB5q2bANAheLxtCi49YziJx6kTTQtIi49oZ11CfuI4+8iEMFmXj8wC7Iw0fp7YA8MRSHFYeqL7uNYTQplnmGwNFY+2XviQ1MA3MQpfYtm2EsF7SfqAaxrfdA1GRKVy8hrhF+XReX2f3OD3GFf4bQi+cLpHUw5Eir2G4+8pEUHblhQVWCp5fEzmFS.7BHc50x8BthFeSRmdx9Y2A9WCvbrnw+KFUjZvE8Xjc4jtrcaXLx1DVC9mfqAaKrf9.nWLx9.j+Ef8arZRMRTuXjsIDUjuSLpH0noIDiruHbMnpeVPeHrijt0Ux8hwhFqfzGlrh.LWJZbA.+ZC6AdoMRuXj8NH+umtoMbMX6kEzGAGDovlH2KLaRCiJRUE1bRgvTTCEoHMbMX6mEzGQyhTrPdWj+EpQdXTQp5PziQVWCp5fEzGSQOFYy0vnhT4vuGwNFYq60fmCtFrKwB5kjckzidwbuHNBiuFFUjJeZBwHqqAUUvB5krmEwNFYqxgQEohjnGirtFTkMKnWAlKvIRbiQ1xdbu.uQLpHULE8Xj00fprXA8Jz1SJAohZLxNtidQE4iurNfIUgdd.2J4eciqAUUwB50f8kXGirixvnhTMQaJvISbiQVWCpwgEzqISP5oyTjiQ1AYXTQp1fEP5oWXTiQVWCpQgEzqYyizyS4nFirEM5EUjOlx+PhT1reD6Xj00fZXXA8LYGANex+GRLHCiJR0lMIvwRriQ1+IbMnlYVPOyd5D2Xj0nhTcIaAoXjckj+0d8FeefempbmVsJVPO.lEvKm3Dir+bLpHU20NAbQj+0f+43ZPMbrfdfrk.mM4KFY6EUjacUuiJ0.jiXj00fZbXA8.Z2n9iQ1uFvStN14jZPlCvwS8DirtFTiKKnGX+9.2BU6Gh7CANh5ZGRpgZa.9PTMwHqqAUYwB5AWuXjcETteHhQEozvaOA9V3ZPESVPugX6A96X7iQViJRow2QxnGirqA3ShqAU4yB5ML6KvUvn8AIeGfey5eJK0JMECeLx5ZPUkl5+CcDZj5LFOo9I.....IUjSD4pPfIH" ],
									"embed" : 1,
									"forceaspect" : 1,
									"id" : "obj-76",
									"maxclass" : "fpic",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "jit_matrix" ],
									"patching_rect" : [ 24.166660308837891, 19.999998092651367, 102.133331298828125, 53.92639892578125 ],
									"pic" : "acids.png"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-15",
									"maxclass" : "ezdac~",
									"numinlets" : 2,
									"numoutlets" : 0,
									"patching_rect" : [ 92.133346557617188, 650.2000732421875, 45.0, 45.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-14",
									"maxclass" : "gain~",
									"multichannelvariant" : 0,
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "signal", "" ],
									"parameter_enable" : 1,
									"patching_rect" : [ 92.133346557617188, 599.00006103515625, 235.0, 20.0 ],
									"saved_attribute_attributes" : 									{
										"valueof" : 										{
											"parameter_longname" : "gain~[4]",
											"parameter_mmax" : 157.0,
											"parameter_shortname" : "gain~[3]",
											"parameter_type" : 0
										}

									}
,
									"varname" : "gain~"
								}

							}
, 							{
								"box" : 								{
									"angle" : 270.0,
									"background" : 1,
									"bgcolor" : [ 1.0, 0.972549019607843, 0.874509803921569, 1.0 ],
									"id" : "obj-40",
									"maxclass" : "panel",
									"mode" : 0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 736.0, 148.79998779296875, 185.933273315429688, 200.0 ],
									"proportion" : 0.5
								}

							}
, 							{
								"box" : 								{
									"angle" : 270.0,
									"background" : 1,
									"bgcolor" : [ 1.0, 0.972549019607843, 0.874509803921569, 1.0 ],
									"id" : "obj-47",
									"maxclass" : "panel",
									"mode" : 0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 936.0, 148.79998779296875, 261.933273315429688, 220.0 ],
									"proportion" : 0.5
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-9", 0 ],
									"source" : [ "obj-1", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-23", 1 ],
									"source" : [ "obj-13", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-15", 1 ],
									"order" : 0,
									"source" : [ "obj-14", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-15", 0 ],
									"order" : 1,
									"source" : [ "obj-14", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-13", 0 ],
									"source" : [ "obj-17", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-23", 2 ],
									"source" : [ "obj-18", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-18", 0 ],
									"source" : [ "obj-19", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-23", 3 ],
									"source" : [ "obj-20", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-20", 0 ],
									"source" : [ "obj-21", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-23", 4 ],
									"source" : [ "obj-22", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-14", 0 ],
									"source" : [ "obj-23", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-22", 0 ],
									"source" : [ "obj-24", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-23", 5 ],
									"source" : [ "obj-25", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-25", 0 ],
									"source" : [ "obj-26", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-23", 6 ],
									"source" : [ "obj-27", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-27", 0 ],
									"source" : [ "obj-28", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-23", 7 ],
									"source" : [ "obj-29", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-29", 0 ],
									"source" : [ "obj-30", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-1", 0 ],
									"hidden" : 1,
									"order" : 7,
									"source" : [ "obj-31", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-17", 0 ],
									"hidden" : 1,
									"order" : 6,
									"source" : [ "obj-31", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-19", 0 ],
									"hidden" : 1,
									"order" : 5,
									"source" : [ "obj-31", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-21", 0 ],
									"hidden" : 1,
									"order" : 4,
									"source" : [ "obj-31", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-24", 0 ],
									"hidden" : 1,
									"order" : 3,
									"source" : [ "obj-31", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-26", 0 ],
									"hidden" : 1,
									"order" : 2,
									"source" : [ "obj-31", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-28", 0 ],
									"hidden" : 1,
									"order" : 1,
									"source" : [ "obj-31", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-30", 0 ],
									"hidden" : 1,
									"order" : 0,
									"source" : [ "obj-31", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-36", 0 ],
									"source" : [ "obj-34", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-36", 0 ],
									"midpoints" : [ 824.5, 348.0, 751.5, 348.0 ],
									"source" : [ "obj-35", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-23", 0 ],
									"midpoints" : [ 751.5, 537.0, 101.500000000000114, 537.0 ],
									"source" : [ "obj-36", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-35", 0 ],
									"source" : [ "obj-37", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-42", 0 ],
									"hidden" : 1,
									"source" : [ "obj-39", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-1", 0 ],
									"hidden" : 1,
									"order" : 7,
									"source" : [ "obj-42", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-17", 0 ],
									"hidden" : 1,
									"order" : 6,
									"source" : [ "obj-42", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-19", 0 ],
									"hidden" : 1,
									"order" : 5,
									"source" : [ "obj-42", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-21", 0 ],
									"hidden" : 1,
									"order" : 4,
									"source" : [ "obj-42", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-24", 0 ],
									"hidden" : 1,
									"order" : 3,
									"source" : [ "obj-42", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-26", 0 ],
									"hidden" : 1,
									"order" : 2,
									"source" : [ "obj-42", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-28", 0 ],
									"hidden" : 1,
									"order" : 1,
									"source" : [ "obj-42", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-30", 0 ],
									"hidden" : 1,
									"order" : 0,
									"source" : [ "obj-42", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-36", 0 ],
									"midpoints" : [ 954.5, 498.0, 751.5, 498.0 ],
									"source" : [ "obj-43", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-46", 0 ],
									"source" : [ "obj-45", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-36", 0 ],
									"midpoints" : [ 1074.5, 498.0, 751.5, 498.0 ],
									"source" : [ "obj-46", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-8", 0 ],
									"hidden" : 1,
									"source" : [ "obj-6", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-73", 0 ],
									"hidden" : 1,
									"source" : [ "obj-71", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-14", 0 ],
									"hidden" : 1,
									"source" : [ "obj-73", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-75", 0 ],
									"hidden" : 1,
									"source" : [ "obj-74", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-6", 0 ],
									"hidden" : 1,
									"source" : [ "obj-75", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-71", 0 ],
									"hidden" : 1,
									"source" : [ "obj-75", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-14", 0 ],
									"hidden" : 1,
									"source" : [ "obj-8", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-23", 0 ],
									"source" : [ "obj-9", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 122.0, 99.0, 70.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"tags" : ""
					}
,
					"text" : "p quickstart"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-1",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 8,
							"minor" : 5,
							"revision" : 0,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"classnamespace" : "box",
						"rect" : [ 0.0, 26.0, 1306.0, 721.0 ],
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
						"showontab" : 1,
						"assistshowspatchername" : 0,
						"boxes" : [ 							{
								"box" : 								{
									"fontface" : 1,
									"fontsize" : 16.0,
									"id" : "obj-13",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 409.000030517578125, 156.333332061767578, 223.0, 24.0 ],
									"text" : "Analysis"
								}

							}
, 							{
								"box" : 								{
									"basictuning" : 440,
									"data" : 									{
										"clips" : [ 											{
												"absolutepath" : "horn.wav",
												"filename" : "horn.wav",
												"filekind" : "audiofile",
												"id" : "u756006934",
												"loop" : 1,
												"content_state" : 												{
													"loop" : 1
												}

											}
 ]
									}
,
									"followglobaltempo" : 0,
									"formantcorrection" : 0,
									"id" : "obj-16",
									"maxclass" : "playlist~",
									"mode" : "basic",
									"numinlets" : 1,
									"numoutlets" : 5,
									"originallength" : [ 0.0, "ticks" ],
									"originaltempo" : 120.0,
									"outlettype" : [ "signal", "signal", "signal", "", "dictionary" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 412.000030517578125, 219.0, 150.0, 30.0 ],
									"pitchcorrection" : 0,
									"quality" : "basic",
									"timestretch" : [ 0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-18",
									"maxclass" : "ezdac~",
									"numinlets" : 2,
									"numoutlets" : 0,
									"patching_rect" : [ 412.000030517578125, 389.2000732421875, 45.0, 45.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-21",
									"maxclass" : "gain~",
									"multichannelvariant" : 0,
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "signal", "" ],
									"parameter_enable" : 1,
									"patching_rect" : [ 412.000030517578125, 338.00006103515625, 235.0, 20.0 ],
									"saved_attribute_attributes" : 									{
										"valueof" : 										{
											"parameter_longname" : "gain~[7]",
											"parameter_mmax" : 157.0,
											"parameter_shortname" : "gain~[3]",
											"parameter_type" : 0
										}

									}
,
									"varname" : "gain~[1]"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-27",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 609.000030517578125, 227.0, 31.0, 22.0 ],
									"text" : "sig~"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-28",
									"maxclass" : "number",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 609.000030517578125, 196.0, 50.0, 22.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-31",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 412.000030517578125, 281.0, 217.0, 22.0 ],
									"text" : "nn~ ordinario_cond_pitch forward 2048"
								}

							}
, 							{
								"box" : 								{
									"fontface" : 1,
									"fontsize" : 16.0,
									"id" : "obj-12",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 66.0, 156.333332061767578, 223.0, 24.0 ],
									"text" : "Conditioned generation"
								}

							}
, 							{
								"box" : 								{
									"basictuning" : 440,
									"data" : 									{
										"clips" : [ 											{
												"absolutepath" : "horn.wav",
												"filename" : "horn.wav",
												"filekind" : "audiofile",
												"id" : "u756006934",
												"loop" : 1,
												"content_state" : 												{
													"loop" : 1
												}

											}
 ]
									}
,
									"followglobaltempo" : 0,
									"formantcorrection" : 0,
									"id" : "obj-11",
									"maxclass" : "playlist~",
									"mode" : "basic",
									"numinlets" : 1,
									"numoutlets" : 5,
									"originallength" : [ 0.0, "ticks" ],
									"originaltempo" : 120.0,
									"outlettype" : [ "signal", "signal", "signal", "", "dictionary" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 69.0, 219.0, 150.0, 30.0 ],
									"pitchcorrection" : 0,
									"quality" : "basic",
									"timestretch" : [ 0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-8",
									"maxclass" : "ezdac~",
									"numinlets" : 2,
									"numoutlets" : 0,
									"patching_rect" : [ 69.0, 389.2000732421875, 45.0, 45.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-9",
									"maxclass" : "gain~",
									"multichannelvariant" : 0,
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "signal", "" ],
									"parameter_enable" : 1,
									"patching_rect" : [ 69.0, 338.00006103515625, 235.0, 20.0 ],
									"saved_attribute_attributes" : 									{
										"valueof" : 										{
											"parameter_longname" : "gain~[6]",
											"parameter_mmax" : 157.0,
											"parameter_shortname" : "gain~[3]",
											"parameter_type" : 0
										}

									}
,
									"varname" : "gain~"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-5",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 266.0, 227.0, 31.0, 22.0 ],
									"text" : "sig~"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-4",
									"maxclass" : "number",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 266.0, 196.0, 50.0, 22.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-2",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 69.0, 281.0, 217.0, 22.0 ],
									"text" : "nn~ ordinario_cond_pitch forward 2048"
								}

							}
, 							{
								"box" : 								{
									"autofit" : 1,
									"forceaspect" : 1,
									"id" : "obj-7",
									"maxclass" : "fpic",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "jit_matrix" ],
									"patching_rect" : [ 103.499988555908203, 21.447814931696115, 130.0, 37.936363636363637 ],
									"pic" : "/Users/domkirke/Dropbox/code/vschaos2/assets/logo.png"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-30",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 4,
									"outlettype" : [ "", "", "", "" ],
									"patching_rect" : [ 804.66668701171875, 31.333333969116211, 56.0, 22.0 ],
									"restore" : 									{
										"gain~" : [ 130 ],
										"gain~[1]" : [ 130 ]
									}
,
									"text" : "autopattr",
									"varname" : "u531005133"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-29",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1032.0, 106.666671752929688, 29.5, 22.0 ],
									"text" : "1"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-23",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 994.8333740234375, 106.666671752929688, 29.5, 22.0 ],
									"text" : "130"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-19",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 994.8333740234375, 77.333335876464844, 44.0, 22.0 ],
									"text" : "launch"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-15",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 858.0, 106.666671752929688, 29.5, 22.0 ],
									"text" : "0"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-14",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 942.00006103515625, 106.666671752929688, 29.5, 22.0 ],
									"text" : "0"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-26",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"patching_rect" : [ 902.66668701171875, 38.831996917724609, 34.0, 22.0 ],
									"text" : "sel 0"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-25",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"patching_rect" : [ 902.66668701171875, 13.333331108093262, 40.0, 22.0 ],
									"text" : "active"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-24",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 902.66668701171875, 106.666671752929688, 29.5, 22.0 ],
									"text" : "0"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-22",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 902.66668701171875, 70.666671752929688, 35.0, 22.0 ],
									"text" : "reset"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-20",
									"linecount" : 2,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 240.000030517578125, 48.333332061767578, 494.0, 33.0 ],
									"text" : "VSChaos can be also be used as a neural audio effect, inferring latent positions from the audio."
								}

							}
, 							{
								"box" : 								{
									"fontface" : 1,
									"fontsize" : 24.0,
									"id" : "obj-17",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 240.000030517578125, 13.333331108093262, 191.6666259765625, 33.0 ],
									"text" : "timbre transfer"
								}

							}
, 							{
								"box" : 								{
									"autofit" : 1,
									"data" : [ 8126, "png", "IBkSG0fBZn....PCIgDQRA..APO..D.BHX....PpFZ.5....DLmPIQEBHf.B7g.YHB..eTWRDEDU3wY6cuG+kTWWGG+0ue6E32hvBHWzX2kRAVPItlkxMyRhKlQp.pUVf30REUP7FHjWRDDwn7FZpkJpDgIfZZdAHLQ4VXDfjJKTJKnrrKBHK6s9iu6IVVNyuemKyLe+Ly754iGe+CQX98cly464y4Lym48LAv7QsA6AvoCreav+reBvaC3BAVWNlTRsbSB7h.dh.uWf6MuSG0kMAVPuoaa.NYRenxrJ3emqD3MBb800jRpCX+H8kn2i0++9mA7N.9z.qMWSJ0cYA8lq4.7RIUndPdMbsj9fl2AoO3QRilE.71AdtE7++0C7l.9N01LRhGcA8UCrpLMWzf6P.NSfEOB+2tBf+JfO.9ZszvXJfSD30CLuY3e20A7OB7V.9ep34kDj9QdL+MXroYc5nYxt.bIj9vhwcby.Gd8N8kZjl.3E.baL7qytefSkY9K.HMtlBrfdSv7I0vMqjxoX9FN9xLZ+Reotf8A3xY7Wmca.O+ZdtqtEKnGbSB7R.VJkeg7Mb7P.mE1OER8rc.eTf0P4tV6x.16Zb+PcGVPOvN.fqgpsP9FOtSRMZ2j0v9mTDMWRWi7kS0sNa0.mKouzfTYwB5AzBA9rj5J85rX9FNtVfCrp2QkBlCmTukTWqytGfWGquYljFSVPOPlhTHvb+juB4a3Xs.eNfEUk6zRAvhI0KI4Zs1MAbXU9doZ6rfdPbz.Kg7WDueC6RW0VMeR8NxCQ9WmsNR2AK6RktGq1LKnmY6EoljI2ePxfL50ktSTIGIjpOSRpWQtSx+5pMdrRR2QK1fpZXYA8LYaA9HjZNlb+AHC63xwtzUMWGHodDI2qilowcR5NbwFTUCJKnWylColf4dH+efw3LVC1ktpYYQj5Ijb1roix3ZHcGuHMSrfdM5PI07K49CHJywxIcK9XW5pnZd.mFwoYSGkwZIcmurvx8PiZYrfdMnLiq0nNtYrKcUrLAod9XThq0nN50fpSUhGmT6gEzqPUYbsF0wWBiQVke6MkSbsF0wRHcmwHsgrfdEXRfiipOtVi5vtzU4x1Qp2NJ63ZMpCiQVsgrfdI6..tZx+B8HLrKcUcYNT8w0ZTGqlzcLy1N1GEUSmEzKIKD37n40As0wvtzUUo5NtVi5vXjUVPeLEs3ZMpC6RWU1VLod1H2u2NZCiQ1tKKnOFhbbsF0gcoqFWQKtVi5vXjs6wB5ifnGWqKA3cAboAXtLcyQ6RWMLljTOYDw3ZMpCaP0tEKnODhdbsd+jN8+a3u98n.t0.L2JZXW5pAwARpWLx86WKZrZfUEf4QQikR5NuwFTscyB5CfnGWqyz0mdJfSA39BvbsnOLztzU8yhH8d6n1ro2CvqkGtQzhdZPd0XCp1lYA8YPzWfNLcP9B.9LD6ObztzUPJtVOUhayltZfOL8+Kg1D9A.mG1fpsQVPu.QOtVWJi98389SruW4sKc6tZBw05kBrmCv9RS7RzolMKnuQlOvYRbiq0xpIWlD3ESrSyN6R2tknGWq2JodRYX0DZhVaP01AKnudMg3ZsJJvsEzM9BLJthdbsdej5Akw8WxF8ay0KizW9PMWVPm3GWq0wofdmAt3.ruVzvtzs8I5w05ZI0yIKnD2midPTYCp1r0oKnG83ZMGMIVzaBP6R21gCiXGWqWModMop3m8npPmrfteK4o2bHcq3XW5pxVziq0kRp2RpqyDzAPru+5uIReIe0Lz4JneTD+qiUTBZE6RWUVlOodgHx8pwYRpmRpac092QkuNSA88BiB0QkG6znpIDWqWLodHI27K8nwUqufdS3WYdpzL9UlQ+raboXW5FIQOtVuQh4oStIjAF1fpwTqsfdS35.2DebhZ+GnYRSKtVipCi32fpUYiCpgWqrfdz6T6gItViplPW51D9P61jon4FWqQkwHqFFspB56Bw9do9NYziq0npIbO7GwSqZaSSHtVaxWNllvkNzFTM+ZEEzMsyxqlPW5FkFepsYuI9wZ5nDWqQkGu0zoQWPuITHoKc6dXW51czKtV8WLlGQOFYuTZ1mQjlpFaAcehgEWMgtzsNCOj1Dultwg8rf1XMtB5MglwxHSLwtzscwWOioEh2UAJowTPuIb6RctjNUj5g0D9Eck8Cfi1llvYbw6K53GirQ899uMoQTPO5AZRjhq0nJ5coaY8HxrMwdhn4wj4qaKzEzidjidajtcczfK5co6shcoauhBQtYSuX5NMa5nvuLV2THKnusjZlhn9q45EWqyqpN.zAzD5R28rh12irneZaMWAFN9zsqaITEzaJw05hppC.cL1ktwgMVU6VW+4OeWQXJnenjZZhb+FqhFWCoG1Dp7E8hIKC33ocVLoI7kpLa9KGMkFTsKbKGVUxdA8cFiqUkD8S26MBbHU1de8qIbYOLbRJe8BEn0P9eMteCaP0QW1Jnabsp9oIzktWDM6tzcuH1Ml3Rvmu80gn2fpKAaP0gUsWPeRRMAQj6f1uDolIoMad.ecfmUtmHEnIzktmAMqtzM525fs83ZMhlflwCVmtXCpNJp0B5QOtVuY5Nw05owCue+U.10rNaJVz6R26f32ktMgqcZWItVip4Q76khtRCpNNpkB5KfTyND0ldZ4.udZmM8T+rPdzKbeHf2GvVlw40zI5co6UAreU1d+3YOHt+p7qlTuSnXXQD6FT061goWkVPeJRM2v8Q9eiP+FqgtYbsddT7wj6B3kALqrM6J1bH8EuVN4+8N8a7KHtegnyk7e7YCGFWqw1AhMnZSTkUPO5w05kS2LtV2eFru880AbPYZNNShZW5dxU4N8XZ6HFeQndIDlMaZ70DZPUiQ1GoRufdSItVmXL2OahljzoFdXNd84A1wbLYG.6MouXVteO05HEYrQuYtNAx6wnKAiq0ln4CbVXCp1DTZEzMtViuikQ6X2CPpI5h3wtnzktMgaul4BbKT+GaLtVaGhdCpZLxVBEzaBw05mCiq0MG3mx3cr71AdADyytQN6R2KqF1+JKOapuiK2Cotq2FXpc4vI9MnZWMFYGqB5GBFWqMEuaJuiq+a.6S8N8GXKhzWfqt5R20PyqWL9pTsGSLtVa+hdCp1KFYWPUc.HnFoB5FWqMKOAfGjxuP1Gk3dGBbf.WKU+609n00NTI5IArJpliGWFFWqcIQsAU6M5ZwH6PUPeKH07AQs4HdHRMugcP6izER0cLe4jZ1p4Va6MCtIAdoTcco6xIteglYx4P4drXIXbs1kEoFTseiaE3Hqr893XfJnabs1b86P8b7+lIcs0hndco6CQ4tOeh04NQIaqA94L9GCLtVUOQoAUmtw2h1cLxNiEz2eF9a0o5bD4BI41r.tdp2WO9xD2uX0hIM+Ji8yagXdVIFFuJF88+0RJQwLtV0FqoDiraSUc.HiJrftw0Zy2qf77ZSzuzGkQW59rq8Yc4a1.2.C+990fw0plY0cCpNrikAb7ztpg7nJnuUXbs1FrU.+Lx6qU2IoqgcDaNw4R5Z+OJco6WMCy2pxAyfueuTrYS0vqtZP0QczlhQ1GQA8+LLtVaKNax+qW8FWKw81Gb6H0o5CZW5tJfmbVloUmuHS+97JI8nrMpmwEEeUcCpVFiKhleLxNEjtN4WA4+.ZQitbbsNJ1UJ+F.abGQOfe1GR2e8yz9weStlfUnclhuyULtVUYppZP0xZzziQ1ofp6dRcbGFWqilWAFAuihIHkDd2N8ete2j5N71nyjG495MQ5QVqTUH5wH6cP5N6po8iHmBhWSKD8eMWSvdP5VzH2uVVzHxm0k4QJ65e.djy4WUFmSUs4S5Zjabsp5TziQ1n93PtHgqfdjudqMQGIoPUH2utVzHx8EwNR5oM25H0M3yNuSmJ2Ahw0ppeyk3FirVPeDGQtina5lhzypauyEFMGDc2G1CR0kgsAUsf9iV1KnG86Y41jE.7oIFeAt9MLaAjz9PbhQVKnODCiq07X+H9o+mMjkT2UuFTM2wHqEzGfgw0Z9MIvwRpaNycA7hF9E9j5150fp4JFYsf9zL5cJUa5YfcaRzeB5YnlHobEirVPuOin+ryVovE4hH+EvKZ3y3dIcPTuwHqEz2nwkSpIGTyvgPJaiycA7hF9fAQpaqNiQVKnu9wsQpoFhXvgno2bH8THZYj+B38a3itSIskT8wHqEzA9fDyn8TCmsgzyM3nGirSUUG.jT3sXfuLVPGpnB5dsxaW1ShcLxtDfitp14kTivQfEzsftFXGEwNFYuLhaLxJop0rwB5VPWCko.NEhaLxtZfOBlI4RcMVP2B5ZDs.fOCwMFY8oFlT2hEzsftFS6OvUS9KfWz3l.NzJauWRQgEzsftJASB7hI87zN2EvKZbI.6RUc.PRYmEzsftJQaAvYRriQ1yDiQVo1HKnaAcUA1YfKl7W.unwRANNLFYkZSrftEzUE5PIcMrycA7hFWMFirRsEVP2B5phMGfWKotNO2Ev623yVc65RpFYAcKnqZx1R59CORwH68S5wxnjZ9rftEzUMau.tTxew70AbZU5dpjpSVP2B5JSNZRYvdtJle63CPHo1DKnaAckQSA71Hcpuq6B5+Q0v9mjpOVP2B5J.VHv4Q8EireafIpk8LIUWrftEzUfb.T8wH6Z.dJ00NjjpMVP2B5JXljTnuTUwH6mn91UjTMxB5vTSPpfdYdJH2df6pD2dp6Y9jdLs9pAlaIsM+E.KF3NJos2vZ9.6aIt8d.fqrD2dRMYyFXUk71bq.VdIuMqRVPWg1t.79.dVkv15s.7tKgsynZ+AthRb68C.10Rb6I0j0TKn+bHcVIKCyB7Ttq36vX7hQ1eDvlV6y5Go8mxcc1MWuSeoPqodJ2OgxbN6CnB0D7U.1CfWOi12X9M.7fk5LRRJXhdA8iBXEk33KTuSeUhVEvYS5zvetj5X8Aw2B3BqpIkjTTL6bOAlAygzyY6xxlUhaKkG+LfWNvGF38CbPSy+tqgzCGFIoVun+KzkJx0A7zAd9jhx094iA78qsYjjTFYAc0zc9j516SizsxUOKmzs9ljTmfEzUavuD3uDX2.9bj53y2NoSOujTmPzuF5RCiaG3EBbNjhQVIoNCKnq1nuStm.RR0MOk6RRRs.VPWRRpEvB5RRRs.VPWRRpEvB5RRRs.VPWihGComRPdWRHIED9AxZXLAveLvoCrCjdfobNYcFIII.+E5Zv8T.91.eJREygTbq9Xy0DRRROLKnqYxiG3S.bk.OsM5+ushTDqJIoLyB5pHaBvaD3G.bLT76UdY.6dMMmjjTArft5m+.fafz0Jeymg+cmMvYW4yHIIMsrft1POIfuFvWDXmFh+6dl.GQkLijjz.wB5BRWK7+ZfqG3fGwsw6kzooWRRYfEz61lEvqD3V.dMLd2Fi6DvwWFSJIIM7rfd20y.3ZA9f.aSIsMeq.OtRZaIIogfEz6d9UAt.fuIvdTxa6s.3cUxaSIIM.rfd2wlA7N.tIfmWE924X.12Jb6KIo9vB5se8hq0aF3jA1zJ9u2j.u+0+2URR0DKn2t8a.bE.eZfETi+cO.fitF+6II04YA81oGGvGG36BreYZNbF.Sko+1RRcNVPucYt.uARw05wRde8cQqetHIoZfEzaOd1jhq0yfT2lGAmD06o5WRpyxB5Me6Fv+BvEAryYdtrw1Lf2btmDRRcAVPu4ZqH0M4WOvgj44R+7f.uaROw1jjTEabh5SkGyB3kP5dJeay7boHeAfSD3Gm6IhjTWgEzaVd5jdHprm4dhTfa.30B7Mx8DQRpqwS4dyvNBb9.WJwrX9cC7p.1arXtjTV3uPO11LRWC5SjXdOcuZfOBvaCXYYdtHI0oYA8XZBfW.v6AXgYdtTjuAoSu9Mj6IhjjrfdDsujtN46etmHE3GS5LF7Ex8DQRROLuF5ww1C7w.9dDyh42GvaA3IiEykjBG+E542bAdM.mBwIg21PqizC2k2DvOMyyEIIU.KnmWOKf2Gvtj6IRA9tjtN4WYtmHRRZ54obOO1UfuBvkPLKleG.GCvSCKlKI0HXA850VR5Wj+8ANzLOW5mUBb5.KF3umzoaWRRM.dJ2qGyB33.dmD23Z8KBbB.+nbOQjjzvyB5UuChzsg1dk6IRA9uHccx+54dhHIoQmmx8pyNB74AtLhYw7kQp652KrXtjTim+B8x27.No0OhXbstFd33Z8ty7bQRRkDKnWtdr.WKvhx8Do.eSRmd8+ybOQjjT4xS4d45tAttbOI5iaE34A76hEykjZkrfd46DHc6eEA2GvIC7j.tvLOWjjTExB5kueDotZOm5EWq6Jv6B3Ay6zQRRUMKnWMdW.KMS+suJRObWdQ.+jLMGjjTMyB5Ui6E3sVy+MWJvwB7TA9N07eaIIkYVPu57IAtlZ3uyJANCRYB+mDXs0veSIIELVPu5rVR2hXUYdneQ.6NvaD3WTg+cjjTvYA8p0U.b9Uv18FANDfi.3GVAaeII0vXA8p2IA7KKos08.b7.6IvWqj1lRRpEvB5UuaG3LGyswZ.9vjtN4mCvpG2IkjjZWrfd838.7+Nh+2do.6CvqD3mWVSHII0tXA85wCPpw0FFKA3n.dF.e+xdBIIo1EKnWe9r.+6Cv+d2Ovo.ra.WPkNijjTqgEzqOqizswVQ2m3qC3yPJtVemXbsJIogfEzqWWEvmpO+yuZfC.3OgQ+ZsKIoNLKnW+dyjdJnAo3Z83.9sXvNc7RRR80ry8DnC5N.NMfsmzoV+dy5rQRRsBVPOONqbOAjjT6hmxcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.SJNo5wcC7OUhaueZItsjTKfEzkpG2LvQl6IgjBkkB7cKos0jSP54y8DkzFDROzQtqRZasi.O0RZaAoCdWVIt8jjT9MafUUxaysBX4k71rJMUz+E5215GRRRZZXSwIII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BTEEzec.yoB1tRRR8SzetjTaVKv5J4wMAbX04Ngjj5jNXfe.kecrsrN2IJASAUSA8diKAXWpq8FII0YrS.+yTc0urfdeFqD38BL+5YeRRRsXaNvoC7fTs0trf9zLVJvwgMhmjjFdSBbL.+TpmZVVPe.FWCvATC6bRRpc3oA7codqUYA8AbrVfyCXgU9tnjjZp1AfOE4oNkEzGxw8C715MQjjj.1Tf2Bvuf7UexB5i3XI.GcktqJMXdt.+Z4dRjYaMviK2SB0Y8bA9wj+5RVPeLGWFvdUk6wRE3WG3aP58gWPlmK41GBXE.mDvby7bQcGa3ZvHLrfdILVMvGAXaqt8ao+eOVfO.o22sguO72NiyobZO3Qdr3V.d1YcFo1thVCl6Qirf9ZH+G3523dvXjUUmYC7pAta5+6+9O.lU1lc4SQ+BouJvtkw4kZelo0f4dzHKneH.WG4+fWQiaB3PqnC.pa5fAtAl4268xy0DLSdNL8GOdHf2OvVkqInZMdlLXqAy035H0XdMISAoDbaq.dU.2I4+.YQCiQVMtdhLbQE4cQy6aoOp1DfeDC1wkeFvqft4YvPimgcMXcOtKReQ9l36s++Kn2ar8.mIo3ZM2GX62Xkqe9sEUvAC0dMNQE4Ykg4aN7lX3O17eP2sWCzvYyAd2T8w05nNdHfyll8Wf+QUPu2oXXWH8Khy8A4hFFirZPLIveFiWTQtRfEW2S7Z1iG3dYzOF8OB7qV2SZ0HLAi+Zvpd7uP6n+PJrfdOGJoqgctOfWz3pA1+R5fgZWdpTdQE4kTyy851Gmw+XzC.7N.1rZdtq3pLWCVEiaA32ux16qeyXAcH0k4uNRccdteAneCiQVsg1Af+AJ+aGyCoN2IpQ+FTt2oK+O.+Qj9kYpa5WgpYMXYMVAvaf1WFKLPEz6YaIc+gGs6UvdCiQ1tspNpHuQZe2BkS.bETMGu91j9xBp6HBw05zMVCveGodEqMZnJn2ydQJQ2x8KNEMVBvQM7GKTCVcEUjul5ZGpl7Bod9.TiQ11umCC9cIQNFWAs+uf4HUPumilTwyb+BUQiKEiQ11t5NpHWFoTspMXd.2F0yws15o3TwKtV23QW5R.MVEz6sANURmt6b+BW+FqF3CiwHaaSunhbUT+um5CTC6e0gSk5+XmwHa6QNWCNHiG.3sS2pIMG6B58rPfOKwsIHtGfWKsuqAZWyrIE.R4LpHWEvtW06nUrERd+R3skaSntnHrFblFc0aixRqfdOG.v0P9eAsnwMR6saka6hTTQ9uVw6qUsyi7eLzXjs4IRqA62nqGzQkdAcHElGuDhcLxdw.6bIrupp2SD3KP9eOyFONhpbmtBseDqyjVSNpM6Jh5ZvdCih3jJofdOyG38RriQ1y.iQ1nJ5QE4MQyqQalD3pH+G652nq+qqhnnuFzyxyiTkVPumlPLx9hwXjMJLpHqNyh3e8OOe5lW+yHw0fMS0RA8dNLhcLxdUXLxlaMgnhrMzk11gxpHOUfqj7+df19ZvpPsVPGZFwH6mAXAU0A.0WFUj4g2CwpGWC17U6Ez6Y6.NWJ2LjtLG2GvofwHaUqoDUjs8jNqtRZuQcbE.6aks22sso.uYh8ZvONs+0fkgrUPum8lXGir2JvQVY68caQOpH6ZYQdS4KW0Vyg6bv0fsKYufNjNcZOepuXnbTFeKf8rpN.zw7qC70I+ulVznqeZdqpmVck0XE.mHdpWGG6NweM3eLc20fipPTPum4Q7iQ1ODv1TUG.Z4dr.+sD6Fwxmm2OrlPCJ1ldVVWGbMX6VnJn2yhH1wH6x.NdLFYGTFUjMWSR7u8k9J3suzLw0fcCgrfdOGHFirMcOSf+Sx+qUEMLLSFLaNvoSrCXjyFXKqpC.MX+t3ZvthPWPGZFwH6EgwH6Fynhrc5IB7OS9e8qngwH6C6IfqA6ZBeA8dlOvYQ5ahm62H1ugwHaxiAiJxtfClX+P535.d5U1der8X.9qv0fcQMlB58rXfuD4+MkEMtCfiktWLxNAveJvOg7+ZPQiuJvSppN.zAMafWMw95xd9.6XUc.HXbMnZbEz64vAtYx+aPKZbUjdpV0E7agQEYWVuXjc0j+Wq623A.9KIcWzzVE80f+23Zv5PisfNj5x7WOvxI+ugsei0B7oo8Fir+J.+8D26FgU.bR38qbcI5wH6sC7BoccuM6ZPsgZzEz6Y6.9nD6Xj8jo8DiraBFUjpXFirUOWCp9oUTPum8A3xI+uYtnwsRyOFYMpH0fXSAdqD6BNeLZlwH6eHweM3Sox160zoUUPGLFYqJFUjZTrC.eJh8oDtoDirtFTyjVWA8dlGvogwH63ZqI1QE4uDiJxlfmFv2i7+9khF+.haLxt0.+M3ZPMyZsEz6YQ.eNh6uPXY.uFR2BPQxrA9KH12RRFUjMKSBbLD+XjcWqn8+gUu0f+bx+wkhFW.tFLRZ8Ez64.AtVx+BfhF+W.+dU1d+vI5QE40iQEYSlwH6LqIrF7YTY68ZT0YJnCoegvKkXGireQfcppN.LCdB.W3.LGy0vnhrcYmH898b+9phF2EvKi588aMg0fuRbMXT0oJn2yVB79HtwH6CB7dn9hQ1nGUjqB3uFiJx1pClzYnJ2uOqnw0AbPU1deRu0f+xLuu5ZvlsNYA8dVLvWl7uXonQUGirFUjJJlModIYYj+2yUz3yS4GirtFTkoNcA8dNbRc4ZtW3Tz36QpKgKSMgnh7Onj2mU7sM.eP5FwHqqAUYyB5q2bANAheLxtCi49YziJx6kTTQtIi49oZ11CfuI4+8iEMFmXj8wC7Iw0fp7YA8MRSHFYeqL7uNYTQplnmGwNFY+2XviQ1MA3MQpfYtm2EsF7SfqAaxrfdA1GRKVy8hrhF+XReX2f3OD3GFf4bQi+cLpHUw5Eir2G4+8pEUHblhQVWCp5fEzmFS.7BHc50x8BthFeSRmdx9Y2A9WCvbrnw+KFUjZvE8Xjc4jtrcaXLx1DVC9mfqAaKrf9.nWLx9.j+Ef8arZRMRTuXjsIDUjuSLpH0noIDiruHbMnpeVPeHrijt0Ux8hwhFqfzGlrh.LWJZbA.+ZC6AdoMRuXj8NH+umtoMbMX6kEzGAGDovlH2KLaRCiJRUE1bRgvTTCEoHMbMX6mEzGQyhTrPdWj+EpQdXTQp5PziQVWCp5fEzGSQOFYy0vnhT4vuGwNFYq60fmCtFrKwB5kjckzidwbuHNBiuFFUjJeZBwHqqAUUvB5krmEwNFYqxgQEohjnGirtFTkMKnWAlKvIRbiQ1xdbu.uQLpHULE8Xj00fprXA8Jz1SJAohZLxNtidQE4iurNfIUgdd.2J4eciqAUUwB50f8kXGirixvnhTMQaJvISbiQVWCpwgEzqISP5oyTjiQ1AYXTQp1fEP5oWXTiQVWCpQgEzqYyizyS4nFirEM5EUjOlx+PhT1reD6Xj00fZXXA8LYGANex+GRLHCiJR0lMIvwRriQ1+IbMnlYVPOyd5D2Xj0nhTcIaAoXjckj+0d8FeefempbmVsJVPO.lEvKm3Dir+bLpHU20NAbQj+0f+43ZPMbrfdfrk.mM4KFY6EUjacUuiJ0.jiXj00fZbXA8.Z2n9iQ1uFvStN14jZPlCvwS8DirtFTiKKnGX+9.2BU6Gh7CANh5ZGRpgZa.9PTMwHqqAUYwB5AWuXjcETteHhQEozvaOA9V3ZPESVPugX6A96X7iQViJRow2QxnGirqA3ShqAU4yB5ML6KvUvn8AIeGfey5eJK0JMECeLx5ZPUkl5+CcDZj5LFOo9I.....IUjSD4pPfIH" ],
									"embed" : 1,
									"forceaspect" : 1,
									"id" : "obj-76",
									"maxclass" : "fpic",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "jit_matrix" ],
									"patching_rect" : [ 24.166660308837891, 19.999998092651367, 77.333328247070312, 40.831997314453126 ],
									"pic" : "acids.png"
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-2", 0 ],
									"source" : [ "obj-11", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-31", 0 ],
									"source" : [ "obj-16", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-23", 0 ],
									"hidden" : 1,
									"order" : 1,
									"source" : [ "obj-19", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-29", 0 ],
									"hidden" : 1,
									"order" : 0,
									"source" : [ "obj-19", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-9", 0 ],
									"source" : [ "obj-2", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-18", 1 ],
									"order" : 0,
									"source" : [ "obj-21", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-18", 0 ],
									"order" : 1,
									"source" : [ "obj-21", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-14", 0 ],
									"hidden" : 1,
									"order" : 0,
									"source" : [ "obj-22", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-15", 0 ],
									"hidden" : 1,
									"order" : 2,
									"source" : [ "obj-22", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-24", 0 ],
									"hidden" : 1,
									"order" : 1,
									"source" : [ "obj-22", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-21", 0 ],
									"midpoints" : [ 1004.3333740234375, 324.0, 421.500030517578125, 324.0 ],
									"order" : 0,
									"source" : [ "obj-23", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-9", 0 ],
									"midpoints" : [ 1004.3333740234375, 324.0, 78.5, 324.0 ],
									"order" : 1,
									"source" : [ "obj-23", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-26", 0 ],
									"hidden" : 1,
									"source" : [ "obj-25", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-19", 0 ],
									"hidden" : 1,
									"source" : [ "obj-26", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-22", 0 ],
									"hidden" : 1,
									"source" : [ "obj-26", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-31", 1 ],
									"source" : [ "obj-27", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-27", 0 ],
									"source" : [ "obj-28", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-21", 0 ],
									"source" : [ "obj-31", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-5", 0 ],
									"source" : [ "obj-4", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-2", 1 ],
									"source" : [ "obj-5", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-8", 1 ],
									"order" : 0,
									"source" : [ "obj-9", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-8", 0 ],
									"order" : 1,
									"source" : [ "obj-9", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 273.0, 99.0, 83.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"tags" : ""
					}
,
					"text" : "p conditioning",
					"varname" : "transfer[1]"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-11",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 8,
							"minor" : 5,
							"revision" : 0,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"classnamespace" : "box",
						"rect" : [ 0.0, 26.0, 1306.0, 721.0 ],
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
						"showontab" : 1,
						"assistshowspatchername" : 0,
						"boxes" : [ 							{
								"box" : 								{
									"id" : "obj-45",
									"items" : [ "random", ",", "sinebank", ",", "pghi" ],
									"maxclass" : "umenu",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "int", "", "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 781.0, 449.5999755859375, 100.0, 22.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-46",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 781.0, 484.5999755859375, 129.0, 22.0 ],
									"text" : "set inversion_mode $1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-24",
									"maxclass" : "newobj",
									"numinlets" : 9,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 499.133346557617188, 535.60003662109375, 156.0, 22.0 ],
									"text" : "nn~ oldsynths decode 2048"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-23",
									"maxclass" : "newobj",
									"numinlets" : 8,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 292.133346557617188, 535.60003662109375, 152.0, 22.0 ],
									"text" : "nn~ ordinario decode 2048"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-22",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 939.20001220703125, 333.133331298828125, 29.0, 22.0 ],
									"text" : "thru"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-21",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 22.533340454101562, 89.133331298828125, 29.0, 22.0 ],
									"text" : "thru"
								}

							}
, 							{
								"box" : 								{
									"bgmode" : 0,
									"border" : 0,
									"clickthrough" : 0,
									"enablehscroll" : 0,
									"enablevscroll" : 0,
									"id" : "obj-20",
									"lockeddragscroll" : 0,
									"lockedsize" : 0,
									"maxclass" : "bpatcher",
									"name" : "_control.maxpat",
									"numinlets" : 1,
									"numoutlets" : 1,
									"offset" : [ 0.0, 0.0 ],
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 570.533248901367188, 355.79998779296875, 170.000015258789062, 150.79998779296875 ],
									"viewvisibility" : 1
								}

							}
, 							{
								"box" : 								{
									"bgmode" : 0,
									"border" : 0,
									"clickthrough" : 0,
									"enablehscroll" : 0,
									"enablevscroll" : 0,
									"id" : "obj-19",
									"lockeddragscroll" : 0,
									"lockedsize" : 0,
									"maxclass" : "bpatcher",
									"name" : "_control.maxpat",
									"numinlets" : 1,
									"numoutlets" : 1,
									"offset" : [ 0.0, 0.0 ],
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 392.433349609375, 355.79998779296875, 170.000015258789062, 150.79998779296875 ],
									"viewvisibility" : 1
								}

							}
, 							{
								"box" : 								{
									"bgmode" : 0,
									"border" : 0,
									"clickthrough" : 0,
									"enablehscroll" : 0,
									"enablevscroll" : 0,
									"id" : "obj-18",
									"lockeddragscroll" : 0,
									"lockedsize" : 0,
									"maxclass" : "bpatcher",
									"name" : "_control.maxpat",
									"numinlets" : 1,
									"numoutlets" : 1,
									"offset" : [ 0.0, 0.0 ],
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 208.133331298828125, 355.79998779296875, 170.000015258789062, 150.79998779296875 ],
									"viewvisibility" : 1
								}

							}
, 							{
								"box" : 								{
									"bgmode" : 0,
									"border" : 0,
									"clickthrough" : 0,
									"enablehscroll" : 0,
									"enablevscroll" : 0,
									"id" : "obj-12",
									"lockeddragscroll" : 0,
									"lockedsize" : 0,
									"maxclass" : "bpatcher",
									"name" : "_control.maxpat",
									"numinlets" : 1,
									"numoutlets" : 1,
									"offset" : [ 0.0, 0.0 ],
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 20.133346557617188, 351.79998779296875, 170.000015258789062, 150.79998779296875 ],
									"viewvisibility" : 1
								}

							}
, 							{
								"box" : 								{
									"bgmode" : 0,
									"border" : 0,
									"clickthrough" : 0,
									"enablehscroll" : 0,
									"enablevscroll" : 0,
									"id" : "obj-10",
									"lockeddragscroll" : 0,
									"lockedsize" : 0,
									"maxclass" : "bpatcher",
									"name" : "_control.maxpat",
									"numinlets" : 1,
									"numoutlets" : 1,
									"offset" : [ 0.0, 0.0 ],
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 574.0333251953125, 155.0, 170.000015258789062, 150.79998779296875 ],
									"viewvisibility" : 1
								}

							}
, 							{
								"box" : 								{
									"bgmode" : 0,
									"border" : 0,
									"clickthrough" : 0,
									"enablehscroll" : 0,
									"enablevscroll" : 0,
									"id" : "obj-9",
									"lockeddragscroll" : 0,
									"lockedsize" : 0,
									"maxclass" : "bpatcher",
									"name" : "_control.maxpat",
									"numinlets" : 1,
									"numoutlets" : 1,
									"offset" : [ 0.0, 0.0 ],
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 392.433349609375, 155.0, 170.000015258789062, 150.79998779296875 ],
									"viewvisibility" : 1
								}

							}
, 							{
								"box" : 								{
									"bgmode" : 0,
									"border" : 0,
									"clickthrough" : 0,
									"enablehscroll" : 0,
									"enablevscroll" : 0,
									"id" : "obj-5",
									"lockeddragscroll" : 0,
									"lockedsize" : 0,
									"maxclass" : "bpatcher",
									"name" : "_control.maxpat",
									"numinlets" : 1,
									"numoutlets" : 1,
									"offset" : [ 0.0, 0.0 ],
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 208.133331298828125, 155.0, 170.000015258789062, 150.79998779296875 ],
									"viewvisibility" : 1
								}

							}
, 							{
								"box" : 								{
									"bgmode" : 0,
									"border" : 0,
									"clickthrough" : 0,
									"enablehscroll" : 0,
									"enablevscroll" : 0,
									"id" : "obj-1",
									"lockeddragscroll" : 0,
									"lockedsize" : 0,
									"maxclass" : "bpatcher",
									"name" : "_control.maxpat",
									"numinlets" : 1,
									"numoutlets" : 1,
									"offset" : [ 0.0, 0.0 ],
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 22.533340454101562, 155.0, 170.000015258789062, 150.79998779296875 ],
									"viewvisibility" : 1
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-8",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1210.4000244140625, 132.133331298828125, 29.5, 22.0 ],
									"text" : "100"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-6",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1210.4000244140625, 84.0, 44.0, 22.0 ],
									"text" : "launch"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-75",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"patching_rect" : [ 1148.0, 47.200000762939453, 34.0, 22.0 ],
									"text" : "sel 0"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-74",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"patching_rect" : [ 1148.0, 5.600000381469727, 40.0, 22.0 ],
									"text" : "active"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-73",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1150.75, 132.133331298828125, 29.5, 22.0 ],
									"text" : "0"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-71",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1148.0, 82.400001525878906, 35.0, 22.0 ],
									"text" : "clear"
								}

							}
, 							{
								"box" : 								{
									"fontface" : 1,
									"fontsize" : 14.0,
									"id" : "obj-68",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 589.70001220703125, 322.5999755859375, 109.0, 22.0 ],
									"text" : "dimension #8",
									"textcolor" : [ 0.996078431606293, 0.996078431606293, 0.996078431606293, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"angle" : 270.0,
									"bgcolor" : [ 0.2, 0.2, 0.2, 1.0 ],
									"id" : "obj-69",
									"maxclass" : "panel",
									"mode" : 0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 578.0333251953125, 317.5999755859375, 166.000015258789062, 185.0 ],
									"proportion" : 0.5
								}

							}
, 							{
								"box" : 								{
									"fontface" : 1,
									"fontsize" : 14.0,
									"id" : "obj-65",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 404.10003662109375, 322.5999755859375, 109.0, 22.0 ],
									"text" : "dimension #7",
									"textcolor" : [ 0.996078431606293, 0.996078431606293, 0.996078431606293, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"angle" : 270.0,
									"bgcolor" : [ 0.2, 0.2, 0.2, 1.0 ],
									"id" : "obj-66",
									"maxclass" : "panel",
									"mode" : 0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 392.433349609375, 317.5999755859375, 170.000015258789062, 185.0 ],
									"proportion" : 0.5
								}

							}
, 							{
								"box" : 								{
									"fontface" : 1,
									"fontsize" : 14.0,
									"id" : "obj-62",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 219.800018310546875, 322.5999755859375, 109.0, 22.0 ],
									"text" : "dimension #6",
									"textcolor" : [ 0.996078431606293, 0.996078431606293, 0.996078431606293, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"angle" : 270.0,
									"bgcolor" : [ 0.2, 0.2, 0.2, 1.0 ],
									"id" : "obj-63",
									"maxclass" : "panel",
									"mode" : 0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 208.133331298828125, 317.5999755859375, 170.000015258789062, 185.0 ],
									"proportion" : 0.5
								}

							}
, 							{
								"box" : 								{
									"fontface" : 1,
									"fontsize" : 14.0,
									"id" : "obj-59",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 31.800033569335938, 322.5999755859375, 109.0, 22.0 ],
									"text" : "dimension #5",
									"textcolor" : [ 0.996078431606293, 0.996078431606293, 0.996078431606293, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"angle" : 270.0,
									"bgcolor" : [ 0.2, 0.2, 0.2, 1.0 ],
									"id" : "obj-60",
									"maxclass" : "panel",
									"mode" : 0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 20.133346557617188, 317.5999755859375, 170.000015258789062, 185.0 ],
									"proportion" : 0.5
								}

							}
, 							{
								"box" : 								{
									"fontface" : 1,
									"fontsize" : 14.0,
									"id" : "obj-56",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 589.70001220703125, 125.79998779296875, 109.0, 22.0 ],
									"text" : "dimension #4",
									"textcolor" : [ 0.996078431606293, 0.996078431606293, 0.996078431606293, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"angle" : 270.0,
									"bgcolor" : [ 0.2, 0.2, 0.2, 1.0 ],
									"id" : "obj-57",
									"maxclass" : "panel",
									"mode" : 0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 574.0333251953125, 120.79998779296875, 170.000015258789062, 185.0 ],
									"proportion" : 0.5
								}

							}
, 							{
								"box" : 								{
									"fontface" : 1,
									"fontsize" : 14.0,
									"id" : "obj-53",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 404.10003662109375, 125.79998779296875, 109.0, 22.0 ],
									"text" : "dimension #3",
									"textcolor" : [ 0.996078431606293, 0.996078431606293, 0.996078431606293, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"angle" : 270.0,
									"bgcolor" : [ 0.2, 0.2, 0.2, 1.0 ],
									"id" : "obj-54",
									"maxclass" : "panel",
									"mode" : 0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 392.433349609375, 120.79998779296875, 170.000015258789062, 185.0 ],
									"proportion" : 0.5
								}

							}
, 							{
								"box" : 								{
									"fontface" : 1,
									"fontsize" : 14.0,
									"id" : "obj-50",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 219.79998779296875, 125.79998779296875, 109.0, 22.0 ],
									"text" : "dimension #2",
									"textcolor" : [ 0.996078431606293, 0.996078431606293, 0.996078431606293, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"angle" : 270.0,
									"bgcolor" : [ 0.2, 0.2, 0.2, 1.0 ],
									"id" : "obj-51",
									"maxclass" : "panel",
									"mode" : 0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 208.133331298828125, 120.79998779296875, 170.000015258789062, 185.0 ],
									"proportion" : 0.5
								}

							}
, 							{
								"box" : 								{
									"fontsize" : 16.0,
									"id" : "obj-2",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 296.933349609375, 55.918949127197266, 807.0, 24.0 ],
									"text" : "you can also directly explore the generative latent space on-the-fly by manipulating latent dimensions at hand"
								}

							}
, 							{
								"box" : 								{
									"fontface" : 1,
									"fontsize" : 30.0,
									"id" : "obj-3",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 296.933349609375, 14.007445335388184, 665.0, 40.0 ],
									"text" : "direct exploration of the generative space"
								}

							}
, 							{
								"box" : 								{
									"autofit" : 1,
									"forceaspect" : 1,
									"id" : "obj-79",
									"maxclass" : "fpic",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "jit_matrix" ],
									"patching_rect" : [ 1102.166748046875, 674.976806640625, 158.26666259765625, 46.863375418526786 ],
									"pic" : "logoircam_noir.png"
								}

							}
, 							{
								"box" : 								{
									"autofit" : 1,
									"data" : [ 26841, "png", "IBkSG0fBZn....PCIgDQRA..CfH..D.hHX....v.u374....DLmPIQEBHf.B7g.YHB..f.PRDEDU3wI6cmGubTUl+G+ycI6aDBKYCHjvRBPB66aRX2vtFjMADAYGQ1Q1gerNBL.BLfv.CH+X.QFDPDYDi+PTbhCnnSbDzvnS.cRDUHQAYQu+9impmtu8sucWc2UUOmp5uue8540Mou8sqmp56s55Tmy44.hHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHR5qKuS.QDQDQjNRCEXh.8.7d.+Qf200LRDQMPTDQDQDIUMMrFBNzn++X.1BfiDX5U77VAv9CrfrL4DQDQDQDQjrwg.zWSDpwghHhHhHhHEL8BLeZtFG1GvC3QxJhHhHhHhHoiUA35o4abXe.eFGxWQDQDQDQDIEr4.KjVqwg8ALqrOkEQDQDQDQjjzHANVZ8FF1GvsCzcVm3hHhHhHhHRxYC.dLZuFG1Gvbx5DWDQDQDQDQRFiF3jn8aXXe.WJZ4WSDQDQDQDIWZiAdRRlFGtDfUOaSeQDQDQDQDocMdfykjoggkh8LS2CDQDQDQDQj1R2.aKvySx13vOGZnkJhHhHhHhjarp.WFIaCC6C3t.FQFteHhHhHhHhHsnt.9H.uBIeiCeNrFdJhHhHhHhHAtw.bNj7MLrOfECLyraWQDQDQDQDQZUqOviS5z3vk.L6raWQDQDQDQDQZE8Bb.jNMLrTiCmSls2HhHhHhHhHsjUC3FI8Zb3hQ8bnHhHhHhHRvaa.dYRuFG9L.SOy1aDQDQDQDQjlVu.GFoWCC6C3NAVkrZGRDQDQDQDQZdqDv0R513vKFsNGJhHhHhHhDzlAvSQ513vqBX3Y0NjHhHhHhHhz71IfkR513vqE0yghHhHhHhHAqgBbbjtMLrOfaFXjYz9jHhHhHhHhzjl.vsR523vaGXTYz9jHhHhHhHhzjlFvSS523v6GXbYytjHRZpKuS.QDQxM5BXkAlB1EcNKrdK32C71.+ZfeDva4T9IhzeaBvC.rAo714qA7owNWfHhHhHRA2HANHfGiF2KBKFXu7IMEQpvdP52qg8ArPfIkQ6ShHhHhHNaZ.OLM+EMNEGxUQDnGfijrowg8ArQYytkHhHhHhGFJ1vHci.NQZ8xg+gl0ItHBCG37H6Zb3dmM6VhHhHhHYodvtPuGmj6BGeQTotWjrz3AtMxtFG9YQ0xBQDQDQJjNZRmKfb9Y39fHcxVCfmjrqwg2KvHxhcLQDQDQjr0TH8tHxECr5Y2thHcjlEVghIqZb3hAlZlrmIhHhHhj4NHR2Kl7FA5My1aDoyQW.yEX4jcMNrOTUJVDQDQjBsqjz+BJ+XY1diHcFFIvoS11vvRwXxf8OQDQDQDm7zj9WP4xAV+rZGRjBrdA1Nx14aX0w3S88RQDWopOkHhz4pKf2lroGA9FXK8EucFrsDoH4PA1.fg.ruQ+aO8v.uJvuF39AdOeSGQjjlZfnHhz4ZX.+kLb6c7.2YFt8DoHXR.y.qgXKzw73qBbO.iFXm.9q.WGvq6XNIhHhHhjfVKx1gl1xAVsLYOSjhm4heCqzGAqgghHhHhHEX6OY+EZdRYxdlHECCAqgY6EvRvuFHtMo8NpHhHhHhu5E+JzEqaFr+IRdWu.KE+ZTXo39AFdJsONCfKFXlozquHhHhHRLso32EbdOX8LhHxfab3eiCeYfImh6iGez14oQ0ECQDQDQb0kiuW34dl96hhjqsS3eCD2pTde77pXaMzTdaIhHhHhLHVC7+BOWDvDR6cTQxoFKYyZTZ8hSN02Kgyuhs2nxfsmHRLzs2IfHhHYtiw6D.asb6S6cRHR.pWfOG91K6mIYyRRSeU7u+aYv1SDQDQDoJa.926gUF6V5t6JRtRuXU5WO+axGGXDo8NZjcOZatbfdhwyuafompYjHhHhHcP5A31w+FEVYrTrEBbQ5jsu.6.vcf++MYVdSaFG14.dvX7b6gxE0l0JMSJQDQDQ5Trs3+EeVq3RQUvPoy1ii++cXe.Kjro2C2If6E6lCch.GaCd9cCbTTNO+ToYxIhHhHRmfQg+E8h5Eab5sqKRPaMw++9qTLuTdeErdMbwQau6CaYznTAqZp.mCVOod6.GFvAw.G4CKDU0SEQDQDosbb3+EeVu3gAFVps2KRXpafqC++6u9vJJMYw5S5dU018lAFI1whGrIx2MICxUu0KvvihdcNWjNHZH8HhHEeqCvuv6jHFlGvS4cRHRFZ+.9ZdmDQVOR1ySrl.KAqwbkzCVi.meUO2aF3agMTaiqyD3FZmDLCMxnXz.iIJFWTT5eOdfUAaYHZyAVsZ7575.+Tr4s4aA7l.KK5quUz2+0Ad2zaWQDQDQx6FBv8f+8NQbhEArpoygAQBNgTEE9Slv6a6Qzq6Tp5w2vDLmWB9u1INZr8wMBqHCsu.GAvoCbs.ODkajbVEKEMj8EQDQj5X+v+K9rYhGGaNIAViaGEZM6UJdl.vBv++dqzeykjEllohsrUzGv5V026rS3be6Rv7tZcCLVrdzaN.yE3P.NCfaE3kS38kjLlcJb7PDQDQJ.lDY+cuNIhECbMT9hLeArpV3pjrGdDwECE3FYf+d+yB7X03wS6XKS38uqthW6IVwiOdJ+2zIUbwIP91E1HWX1XyOxS.qn3TpP5j2hCJZ+pWrd3T2fMQDQDAvtnfJuPshPrHfcFM+4k7qdANWpcCcNjZ73ocb8jrMfXcq50uxdlbdoP9ubfMsIxugg0P00.XqwVdMdpTHu7LJ0n7Ocz++4.93nhbizDzurHhHES6.v44cRjv1.fuC1764VA9PWyFQZN8.bxX8NdIuJ1h+9aC7+ygb5lA9aI3q2AVw+9VnbwRoWrJobRaL.uDvS.7CA9yQO96GEqLVuCNUrpd55kB4Pn4xvVlP9qQ++cDq3CMIrdFUm2TDQDoCzJgsNg48cxNMiSLwNZIR13vo++N7Ci0vkY.7Jj8+MzQkv6eSppW+cshu214v9WZGuLvsUmu+B.1IrFoVpCYFC1M2Jqy0aBqmSGc0uoIhHhHcFNC7+hmxhXyRpCXhjx1Y5+u6dBXC+xUG34I6+am6gjecG8Xq30eoXMFBrhM0i3v9XZFKDanb1MvyLHOmKFqQySDan2tG.2mi47gGkucg0SpaIVuZKhHhHEbaL9ewSYUbeIzwLQRSUWrnNPrKReD.2MY+e2rDr4fWRZUpZe7Bq36k2pjxwIJs+MTfmN.xm3FOL8uQpWAIaErUDQJT5AacLZVn6nljeMBfGE+uHjrLTkMUBcW.k+80aFqwgcSxujOD2XOS38ugv.KHVGPz2qHeCqtRr04Puyi1MtNfgiHhHCPOXCWsSFX2bNWDoUcj3+Eaj0w1jHG4DIcLdrgaYoeecShd78Ee96kKfjspkNFrdSq5syBwpVqI8xZQ8hiEXyA1Jrk5gKNC21483zPUGZQDQjBmoi+WjgGwmHIN3IRJ4Do7uqNunGa13yeq7njLEojtvFhp6K9L+IqU7hLvQ+yVG.4UdJJ86mhHhHRAPOXkTduu.COhKJAN9IRZXmv9czkCr6QO1piOUX3khcSjZUiEaT1bL.OoC4ebhOez93T.N5.HexiwliHhDXlFvGAqZus8.aA1cZcFXqiQizqDSj.2ti+WXgWwyj.G+DIoMarFFtHr4gG3WQooOJ2.03ZnXU5xChN2a9TmX7J.qMhHR.Yknwm7ZQ.2K1baX9XMjbch9Yiy3muarFZV4PQ4LidsTwtPxiFO1vqx6KrvyHoKW+hzNlF1mU8..qUzi0MvYgO+8wYQi+7wt.lLvbw5ItE6Ttpv+3wo7RThzgRSHUIqLRf0D6NSMcr4uv3AdSf+Hv+IvOB3MZiswKg0aBuBvuF32C7V.q.6jdiCawhc+AVF17w3mD8+2ynG67A9p.ucajGhjkNSfuf2IgyVUrykHRHXd.eHv2A38hdr8C3q4Pt7OC7oAdmZ78FA1HzYSA9XXeVnHfULiJUYZEQjD0jv9PmaD+uiXMS7hXCGmdS9CIhjn7pXWDZwLZ2Cjhjh7phktTJ2ClkrxXSkiKf9utEpPQ0wlgzwRW.rjlFJ1c0ecq3wtZrOTZS.lCvOG36gMbbderFlc0QO2sB3mhM7wVYrd.bkAVMrdfblX8B46BbXUrMdUr4NQqZyv5IxuH15CzRpyysGrhNv1iUwztLrdrLoUppw8GSoWeI+oGr0QMwJfFhDZFNVu28EcZ6erXillQgMOH2KZ+h5z2DawU+Wg8YxWDvgzlulRX5jv9cHQDIwLZJOm91Cr6F0hHdKB8GZzyecazSrBSB6tk93XCal0.3Vo8uCZKE6t+1MViQ2arSXduT6JQ28fstr0nBpyvvFVbMiRkK8mDaMKZGQWXbmLUB2KG6XadrTjjznAlEvsge+MwMf0I.6Cwe9D9LXM963vZX6EVie1csh8yt.tJG2GUj9wHPDQRPmbT.kuP1ki0qhkdrwMH+r8hU0zN8pd7I.bM.mB1blnxSb8.Qai6mxKBvi.6CIShSRdF.CohsWO.SLZ+3jAdgpd9KE3RwZb4FF8bGI1cTdbXMh7Uv58w3ZD0X6rDfOIw+j3cQxtHIK9nWf6C+u3gPI9ns2gSQRTqO992CKEqAp.rAXeNzQh8YUGEvGG6lctyXilmoxfeSM2jpdsuCrg19FhcyR89u8UjNwyiccJhHRh5S.rcQ+6Yh0Pl8shu+shUXXFLy.6jTGAk6krpKk+KAqgaaBVCFWTzierXCEUvZTYo6.5YDkKGMs1ILOa5eiOqrgV8FkyGDvc0DulysNGCpkSDaXut7JdM9DX85JXMbcOYv6QkIhcb5bvN1H4S6B9eADgTng3lDR5k9eN5rNVD1ZAXqpKrO2cJXSeCu+6aEYe7vXEaolcjNIhH0U0UH2JmuqcC7PX2QSp5w2QrFu7PT9DUKgx8PXyD2M1Pk4wh9+U1acaJ1cHqV+bG.VkVcNX2g0OE17h7QvJC3D80C.aQCd6n+8tHXC40CI5064wtKtSqFaql8ju6J1GXuZXy8i9vl2iSCq2LKUPfNk57ZbPQOmmBszdjG40BscHGmPacDUjj0Zie+svhvtQfshUCaIe5QbL+UDVwUfHhjx5BanrbxXm34Lq36MTfOGM+IutCrdF73wFpkebrdpb9XM.8yiMLSuYFXOlMbrgIyQf0vpR8z3k2j6WijAe3xt1TtGPGQE48yi0ymMqcAqAySA634VgMuQJ85te.aAvCF876N54NUJutF0EvtgMDWO+VHGD+zMI2vltHEmS6bPUjD1Efe+svrGjbpdy++Yf84nd+2wJBu3En7TCRDQREUegse9nGe3X2kpJ+dGA1cybkvZ70TAVGrdhaFQeugmB43vIcWzsmCvVhUU4pTu.aNVuRdDXM1cOwZr2zwFxrqJvUhc74lobuxNFJudEcXXM.7AhdstD5+w0ilxWnvXv5oydi1lGE1b4ZVjNGak125h+WvPHFWZabLUjjz1ge+cvsRsWeq2TraJX0lDvE6X9pHeD2D10Fn5WfHRhZMi9Z02U0K.6NScoU83IQYUdN.GH4ip7YqVI31uJdMFB1vr6Yh9+6Uc941vZjC6H8umHeErFo1npwpjsTQgn1wWncNnJRBYJ.uL982AU2HvdvFMM8Q4oGAX2TvCGemmjJxewdfHhjf1TrOj5fo+mr4pAN2pdrEQ4gBYqZmp3069wFlmi.6CHmVa9Z2NJMjV2lnuNzJd7V4Cpq0hf7zq3eOMr4O4Rq5mavJLN8fcr5fo7717Rh9diCq2bE+zC1x3h2WjPHF2QabbUjjvXwJrGd92AUd9+IhU0u6K5qGBkmG96sy4oh7YbuHhHIrR8d3hvJ7K6Bvix.OAzQj.aqIgsVAVqSvcWU8bWWr4p39iMDVajdvZrzDqJFO8uP7TKSAXAT9XwBwFpribPx03D2GkmakiBXiv54uyjxCSzMqpel6IF4Z2XCm2qBa8vpzcE+1v5cxpGhrR5aKw+KPHTiGpMNtJR6paBigp45icyPmG8e8KbqvldAKB67HaQ.jqJxmQit1AQD4+0dfU0y1957bJstP83TdbrupLvEg2lYcArd1Tp8I2t0pddUOj8p0vacLXCW0alF2SeOH1EJbLXC2mYhM+AKMu+FNVu50GVEVsardTrcNg8Rn1245RUH0gx.6EwOdCN9UoYR+qpr8g0318izc9ZJk0MM2xmRmV7rs9gVQZa6KY2uq+4XfyY+RwRw97fJermF67zCGanXubraL4M1haeEc1QbWykEQ5vsFT9CjdAF7FLLJJeBlyBankV8b03NSv7ZOn1mbaIX8vXIaI8uQeKhANI+24A40pYiZ03xmdPd7jHJM+KGrFfVZcpLNFAvoUiWiG.X8ZhWGo0ndOr9wha8CshzVVOxt4x2UBLZF7knoZEUtl31KkmVBSfZOJdTnXvhEhHhDSiFa3Ud1Xm.YMqwyYXXMJrQm74Szl4xvwV5HZzP8Yo.WH1cQErF+bjU78qUOgtpX8X1hhw9QnDyKZ+bv99KmAe9HVK8xf+93AfpvYoE06gwKpWY7WjzvHH6lWvO.1m2t8036cG.2dMd76A6yAtFrdc71v5Ax8.qxfudYTtqnXD2HhHRLzKVwVYK.tErEd8Z0Ch0pmmpUTqpqYbLDrIfe0CW05EyupWiQi8AnWI1btavtXyIS+q1mEg3Hpy9a0FA16yu.kKjMkhSGM7SRCp2CiWnklEIqUpBglEw5h84qOXUO9wi8Yw0ZsW7bv9bwMFatt+zU88aldhTghOFhHRCLD5+RyvMPsm+f8h0XhROu8.3hn1m7ocK7ICEa3yr8X8n0I.bYT64m2bZisimqyUoU74wJ9N0yHvtfnaGa3.ObrFEV4qyChsNUJIC06gwOFcKdLVjVwpx.ma2oYrcLvkDpiAaJQLTF3na4xw971sFaT9T85PrBEMaLEDQjF3ihcBiGAqGNFrdfpGr0Tu9vtP2d.9HLvS7bOoa5xvwF9qaE1bxncZL5HwFK9kx8a.qBwU4ikGiE.rsT+gJ5ITwyepXMHu5WmkicmFU0Nq8odOL9w3awiwhzr5F6lp44uueCX2nVn1mmXZXeV0tQ9+ylT3ebpHhHMvPwpZf8QiWWAmLkOAyxANHp8hB+CfUsOyKVGrFG2GVEralXCyUuOIdRD2B1vFtz5zXk5EqhtdVTd3DOSp87v4Vn+EDHo4zC1MNw6eeHuDklSwhj11Sxlemdw.6CCrAdKfxedYuLvySbqXEBtWoE1lJTTc7Ln0AYQjXnx0PoFsrTLXUSzZEKBqQVqM1cncBX8DU8F5XiBan9LIfUAaIoHtFK1xgQ0yaxUCqAvypA+78fstCdhTLmKGK.3PwFxnUWYWq1HvV7ketpdMVLvNzfeVo1TuG1bwDasCyhzTlBCbojHMhWDadGB1RrToGe4XqQskLuLHWTz4FKEaYJSDQZn4P4Sdb7M34daU7bqUOGNXwyR+Wr6eVr491UDEWCk6Eypial30aBqLVCXtzpd7CL50YAXCQm3nGrF1t6XCEihV4C+XIdExlQDcLn58+iGslI1LTuG17wjaoizhDe8R+arVZEOOkGcN8P+KLZUtV8t9jcKwFJ5LilY4vRJPZTuBHxfYhX24x6BXm.9t034LMf+qn+8chMmMdyX95+Z.eef2A38.d6nG+sA9aXen36VQT54sbf2B3+I540H6E1bo6th9+CA3qi0HGvlqkeip9Y5I548WZvq83hds2RrRKd6TXbBAeNfuHvGV0iuIXePxKWwi0KvrwV5RN2nG61vpzduU5llEBaK1u+Kw2TAdCuSBoP6PvJDWookgMO4e0n++L.9kU78lEvJvFwFeYZtQMiHwUoeG664chHhjOMGrdga2Xf2vg8lx2Ep8mZWPSJE2N1vQcFXCozr7lWTYwTY3.2WE4U08P5tf0yh8E80qG3yBbXXCG18FasEbmpH1UrpoZeXykjGhj8N7kkw4y.WJKVYrgG7pNHGeWKJ26wOBZn.1HCgZW4cUT+XpsxAaQhoMir42iqdc38Lq36ckXKYEUuTWnPQRFKA622EQjlR0Mda1XmP4lA9TTtZBV45e3Do1yGwkBrMoeJ2T5FaNMtALvpc5r.tDZ8S7d6Xygy777F41wlumUZmo92I6dw9ci9vlmhSqNO2Nc6B9+dbdLViV4fsHwvDwlSfo8uCehUsc2fp99EsotfhvKdRfoiHhzj1JrgRX02co8hxmfozDZ9Ni9+WSz++JYfmLZeR47MsrxXCCvSk9uNO1NwIic2gyCyojEf0So0pRmVOkZX7yglyX0xv.dJ7+827XrVsvwaQZjgS1rVj93z+aH4zH49rkNw3YvpN5OECbMhrx34.tef6.aDt7TCR7LM41OOFW.Md8PVDQpoaD6DI6TUOdO.Waz2qzho5KG8+2UrdbpVmPp5dhJOpGrduXWvFtoKfV6jyKFq2WOmV7m2i3Uvt.plw1h0iyOI4qk1jrPkCKaui7vMpnxXsagi2hTOcQ+GILoYrgXy88KE33PKQEMaTZZprlLvOSparFbexXeNae.ymVaoaXXXSClUFajFstXExkOMkWNRNSxWu+8XXetrpKIhHsrc.qnjTKyD6jMSF6Dl2Tz+ep.6G8+DRKDadTT87YqHnzPTca.NRr0jp3dh5yG3hahmeHDM6P6qGrgvx8AbdM4OaQ1nHr5wfOa.jCMSngEkjz1Yxle28nh1dGaFs8JRwMQysLLLbJuTZkzFMVw3aWhxoEw.W5mBk3EANIF707XQDIwzKVia5BaQR+igcBxww.uv2sCqgSMauOkWMBrBvytgcg2Eo0Mwyjl6NONYr65Z2nBKRkNH7+8xRwUf0aFdmGMSLil+PtHCpUm5OzDSp3tn7R.TVrDZTjhCi9Wj4BA8fMUQ.qgnqCVOW58wp9vlCqeBrZofZTnHRlpTgJY9XCgvGCa4QnxSR8JXMZ7tp0KPGhRCK0cC6NNlmFNJ0JlaSt+e8nEe2JMNxlKFMtwLn75AZdIJsnhKR6pWryQk1+N6Rn7MIahMwO29.bgYP9ExwQT625BVy.3zwJLeY4wokhMsUlMwasLVDQRbCmxSx9sjA+DVeBfMkAVw15jMDrO.YewVu.89CeakXOZh82CH5m4ovVyu5zcD3+6ekhKOJm9TY31LIBcCGjjR0SIhzJ1sJ1lMy4.VWfiNixwPLdJxu8.1nvt9nyfxyGxzH9BXC00wlM6VRQilPpRb0CvespGqaJuXzOCrSZudX240k.72OHuVaC1PC4wAd1DOSKFl.VINem.NAxOCEyKC3mC7l.eGfObPddaLvOth++Lw5E0NQqLVAcJTdOdcvtvkOGvM3btzLlE1u64stwFxfCC6bl+YJedRI7McryMk1K.8WLVk89ugUbx92Idyi1kAbH.e6DLW9YXifgeKvuC3OB71Qaq+.v6Dkme.1uWOTrgf6bw5cpr1ogMMVx6FN1M1ZCwJRLmRL9YdUfuFvuAqPhsBf+D16QuC16c+OQOlHhj5lOCrfhT4Bi9gR7uyVklz1ZNCEOi.qv.8YHaVKtRp3ro1yOjYic2Mq749nTLKXQwQHMW+tnJxqqN.xmlIlU7OjmXFA1E3smXCer6D6liUYd8BX8VvNBrZNjiR7MBxlEg9mm9WAMO7l3m87n9CG8mBaT.bLXUE4s.6lMt9XyItohMbVm.VifGRab7Z3j8CYx9n+87ZQxHwdeZevtAc2Kkqlz2J10LogIpHRP4LvNIUogP5pS+WKDuAZtSvub5baPP6XnX891oP9XdKdJLvQpvTn7G5s6.WUz+daa+CO4RU2XYOiJ6Ai6I.xmlI1v3eHusLdrktmKkV6hiuOr0CT0XwvyIR176pU1.mIP7GpgKBas8q5G+owp3pY8xFzgEy7NoiREAlNAcg0Pb0vPQjfTo4EWowy9W.aXAB1cBsYOA+skUIdA1H.1bfyhA1qEgT7QpQtebQeusEaH4MWr48SmjghMWb898mRwETU9ERK4FwIlcrNp2Z5BqAnIcgA4Rw5cGMcO7W8l27IY7HTd9y0EvkzD+rWH1B59cfcSYOYrJBtW2rUuVBGVmrXmSDQj5qKJOjVVIrgAQeTdNS0Jkm+OY1k9cDFM1cP9Vv2KRuVwhYf8VxZD88t5ZruzE42BPPbMVrdRx62apLpbglu2.HeZ1Xih4w9l0LwVDtSyb+lQUgUOMAxtaHRkEkqcsI94NMBuajfWqYuSNK14DQDo9FMkOw77wt6c8gUPZVWZsJw0lgjVlJ1P+IjVfdO2pxwdn7vLcMqw9vkPwdMxbev+2SpLtvpxuwD.4TyFI8PLcHj8Kb4mF14akrSWXq6mYw6uKjxmWain74.aTbSTdsRLjLG74u0CkB5kHhzQaJT6SR+rz5SP8wmo6AclFJVCwuT74CwqNJ0CUiixUAuCFq36TsiEaXnVD0C15Cp2ueTYLspxwUK.xolM1fFenO15Fqf83w9wigFBcYoMmr681k.rU.GIwuwgKF6bkgntH86c8z9u0EQDoEsgjrmb+9y1zWvFRNGI9tXreXXM7XQ.qUTdMcraxP02vfMH5moHNr6lA98dPshpm6gf0XduyqlMJMmnSBy048kkfFkEYgggMm.892cqWzLqurdHKafconSsflIhHAkcjj8j6GYEu1cmI6ARIiBadujEkx8piEC7LQ+6KGqmz15n++tVUd1azy8JSz89vv7w+K5rxXspQNlz2TnrHV+FcfOlFF1niv68mkisDEHom4g+uOWu35H7qdkcCbWjsGW18LYOSDQj5Jo+Pz4D85tEXEF.sdHl85A68gqG+t3mamxMXrVMDbKh9dEoe+nWr0oLuuvyRQs58PnbC2ySw5UuC7MgsO.1WJEKl9W7fjjyZzp3l...H.jDQAQUoQyf2uGWuXRo1dex5PHaOtrIYytkHhH0y9Sxch8kP4Rx8QF8X2TFseHCTWXCMuKG+uP3ZsfMeLXyGwhhPZYsnOpcuGBMW0ULThjZ3HeIAv9RkwigVyXSZ8.bs3+6s0KptvQEh5FaMR9IIa+6gRqGyhHh3n8hj6j6e9JdcGJVQJ4LI7GFMcBlNv4geWPzZTibZ+AdQJNUzzqD+uvyRwYWm77.Bf7qYijnvtLRhewCIKiCIA12jx1S7+8zFE4ggWboQ4QVE2AkWKlEQDwY6BI2I329LN2kl2z.tJRuOj+d.NBfWlF+6FebxOWrTird3+EcVYTqkWjRNp.H+Z1X50Y+ItV2.X+nVwRPU94jxjo0VZlxxXgDlKqEU6TIaOtrKYytkHhJPHRbTqd1oU7C.9QQ+6Yhs138wRnWaI47qvlaZaLv+TJ75OGr4d3NhMb9JYVQecZT9bS+OQeMzqjewwg6cBTgyB3+tNe+7XiQ5KAdMlVB7ZjFlJVudIsmgBb9jL2Lgzz2B387NIhgcLi2d4wyKIhHEV2AIyc+6nid8FG8eXbo4WS3pWfcljupNdGX2g7dwVuC6C3gAlPz+dei19SN5+ubfUJM2QSYgVOS0na5SVsvgmjwzZv9Tbb5Av9wfEOG1euHstRmqIziCMsN.jvx5dh8NxlcKQDQpmwC73jbmbemhdcGBvsF8X2LpmryCFCvIQx9g8WAk6svRyMuICbmXCotRKNzGez2KOO7htL7+hNKEmQLx26N.xylMVqXreUOcA7zAv9Q8hR8xtz71I7+8uFEKF3hH+byvdAx9iQCMS1yDQDYPMLfWgj6D6UtbEzMvJiti34MaDvBHY+.+kTw+9bn7RuwwDsM6EXuI4pRkYsPq2CmZLx4j983rHZ2gB+3Cf8gFEGQatO1oZJz+yyDJQ0qIp4skzjqgr+X1Hyj8LQDQ5mghcR+RUDvylv4B3jvvpR50CSKsh+8hwFNx4cgzv07ziQ91S.jmsRL4XruUOgVQDpVwc2l6ich5A3Fv+26pNtsn7qTw55wRk89zURuFIGmPSIEQDwAiD6jvuL1P1ZuIY+.w4hU7Sj7sUij+Nx+n.SD3Aq3wNUx28x75i+WHZkQb58vQG.4YqDkFRxspcL.1GhSnx7eyY2v+2ypU7bXqmeKJ5+e.o0AfTzDvVFhxpiYKm78mGHhH4ZmL1IieAJOb+RxXextcEIEccj7+twzvZDSk8j39kQ6OoAOFBVCVbZwLmW0.HWakXUh492f4.Cf8g3DaPate1IY0nbCvBw3Ah9ZddYLozbDOKhR85pHRJS2IFoVtCrgwweGv1jPul+LfuIvjvJDDR92xRgWyuLv+WfeM1E2A1EFjGsAXKkKghGIlOuQkpYQ54u1l+7SHQxhz2jwNepTe8.blD1Mn9vh95E.7G8LQZCqHC2V+mY31RjNZpAhR0VYrJn18f0.wjxMA7NXMp3CSvWWwOaYJ7Zt8QQkxKW3dk5hxKqKgfSC32DymadsHP72Zye97RO3j2JjId4ihUzqBcq.3o7NIZCYYwC6sxvskHczzxKfToUE3qhUbPt8D909af0SP+aI7qq3iUG3fyns0NmQamjzrwJvSghuZS7b6T6AwgmHYQ5ai7NAxAVKf6x6jHl9r.uo2IQKZ0wV9ixJucFtsDoilZfnToCD3iD8umeB+Z+6AdczI3KJptW9RSGMseAHIK0Evw5cRTgSg326gfUjZxiZ2FHlWpNhaq2IPfaX.WJkGh5greFv+h2IQLzMVsCn5JE7wP1db9OkgaKQDQvluFo4hd6XvJ.IR92nH6Wfj22LYOKYro3ewunxXRMY9ueAPN2JQ6t.ZGRETnFE4kFy5giD+e+Itw9mRGCRZaMV9dTU7Xa.Y+wqjplHHhz.pGDkRFAo6Ie2PfeaJ95KYmcmr+CpSi46XZnafSv6jnBmBM+e2kWW6Ia24fXdRd88nz1F.7O4cRDSeafmw6jHlJU4wWoJdLOVVN5j9abQbkJRMRIo4uKrLrFT7CRwsgjtFAVOzLBfKygs+mHZ61tCivz1lA7Y7NIpvi1B+LqTieJAoP+2MRRiC3+w6jHvLBf+OdmDMgq.3c8NIhggR4BtUoFnMZfqzgboOG1lMqtv96yQGEciMrm6I56+g.uO168e.VQJRS8FI3nFHJkrbfuCkmChMxqiUURWuF77tDrpg5GzpIl3twhUvUdRrKpYNNjCqWTdDxkB9dHr58vShVqW6a20SPO75z9W73eHIRjLRdsPBkl93Xyi97fuLvy6cRDSSFasoEf2H5qqkS4Rn0.wtvNe4ZfUMW2Hf8jleDu78.V.vqfUj.eUr51fHhDD1Kh+bA33wVJLZzyKuT53kZqafaD68xWA+lqNmLkuCrgpsA+mSSkhkSyO2CK4NBf7uYiE1h6qU5.Bf8i3F6TBr+VjLC7+8jlI1zz4vPpXWnbduEQO1GCeNtsYo4NZLLVfYALOfyCqQ9o095siMcNzvIWDwMiG31vFNZw8jWyBXow34cn.Smv+h6kZacv+KlpOx10ZqVQu.OH9ebpTzN8j4yD.4eyFOaar+VxVF.6GwM9nIv9aQwP.ta7+8j3FWOVOOkWbVTN2K0v1qBeN1kkMrdXXq4n6BvIB7PI39QyDKA3SS9bjcHhjycdzbmv5Y.lRS9yjGWryE6NF68ET0GCr7pGZ1d7+XToX4.SrE2O5N5m268glMdrVb+sRqa.reD23PRf82hh7TO+1G1McKzs6XSOj4S+y8RMP6IwmicoUOH1E15.8VfcSsuQBuyCtDrgQc6VslEIVzbPT1PfqtI+Y9xzbqKceWf2pI2FRXHT9vnPt50MDfOm2IQENKZ8BXxHvVRZxa9yIvqwxSfWirxH8NABDSFaHQmWbN.+RuShXnWr0Rxp0C1MeZdYZ1TVRU48GA17pbsAlMVUZ8ijPu1okoB7UvF5oWNpHUIoL0.QoUFJZKDaHlFWO.cVUXvhht.1CuShHgbUab6vlSNgfUP60aZ400WujnZPthD30HqLDuSf.PO.mIY6B0d630vl294Aeaf6jAVQlmM15jpWZkFH1MVuCtVXE6rsEq.dkWch.6L16MeOmyEQjBp0lleXNr.rarv4Gim68F80MLi1ejj09h+CqlRw1lx6qspgPyM2cS63Xay8m0L.1GZk3VZy8avNul26GwMN0DX+MuqxhmRdH1+z4vPpYkwugR5fEMZ82sGrQ2zlAbP.WDvKD.4cZEmJ42apmHR.63o4OgzAG8y9rM3487XEmlGBUfZxa5FadX38G9UYL+TcOt0sy3+wlRwRwtS4siYF.6GsRb8s49cIKJ.1WhSblIz9ad0XIcqfjIc7HXE8j7loheEmkZE6ZE4VuX0BgsFaN4dU3ak11q3VI+t10JhDfFBs1ECMIrgzSidd6Avw.raY0NjjHVYhWuCm0wShMuqRp4fRRnGBqJWZ616gP3TThZ1HoVzter.XeINw4mP6u4UmH9+dPyD4ok0BvJ5VWLvmjxKoEWCvQguGGuBr05xKiNyFCNXwCflWxhHIjVoh8cQQ+rysAOuGL547TjOuqocRFCVO8NKrO7ew3+G1MXwSicgAghMA+OlTJVNseuGBVgZv68kVItjDXeGrB.g26KwItzDZ+MOZ53+w+lItBxWKqESjZue7Yv541kLHeeE9FIwMHTj+WgzciWxVsx7B7eN5q6XCddy.aHndc.uWKrcjry6A7iA9YXyYzo6Z1Te6IgU0vMjVpANcfeWB75jGqfo.79IzqyeLgdcRaC26DvI8PXUwfajkQ4a5PdwFOHO9pgcinBoaRmT1MPqu7FIx.nFH14ZCZxm+YB7Kh926Z8dhXK3z2H1bDQBaaJ4mFErBrdkNDLcfy06jHxx.dhD50ZrIzqSVKoZfXHcCHpmN0Qlwt.bJdmDMgOKvuw6jnIMX2jvOI1HMoYVhqjryXvVmDEIQnk4hNW+kX97tMf+UrdDDrJlUi5AweFVuG9gsVpIYjog89adwmFadmDB1WuSfJbtjL8dHjeK1AIUCDyKK0Echy2nUB3Z8NIZBeaRtabSVZ8pyi+yxxDQZZ2BVAQJTWRnjbD0ChctlYLed2MVganzEN0ndX30wtKV5DTggAqBxtI.OLV4.Ou3m5cBDYUvlWQgfkA70SvWuIjfuVYoOHgdcTCDCWGN4qyWcA.+YuShVfVVpx2Bk0tXImSMPryzTANtX9bmRU++FM2WtWfg1rIjjZ1e5ei5mL17U6GgMTfySBkeuZ2IbFVtIYuGB424vRR0.w2IgdcRacZCwz0C3K5cRzDtbf+MuShVvXwN+ljecADNe9jjioFH14YDzb89wAP+uv7k2fm+EhsjDnSP4qsAadlNBr2SlGViIdCr4GZdyqB7ZdmDX8by44cRD40I4GBaqYB+5kURpgydRMTUSa+UuSfLTOXyku7hWCan6mmJLMkj2VNNjAZ8.1AuSBQj7mOJMe4S9tvV2DK4AhwOy5m96JxfXewdOXWwlSBdW9sShHTpXn6N9ernTbTI79VW.KM.1uZk3vSniA6Y.ruDm39Rn827fcD+Od2LwdmNGFRcqGvKh+G+Tz9wSSmakNVRHpH0zYoGfSHlO2UP40uoCD6jNkDmdxoS5NbGRlFviC7Mwpdd4oJ92f4aPXTrG5E3j8NIhjF8d3vwJk84QI0PLModcRa4k7rcMBJu96lG7k.9VdmDMgdvVSj2Sf+dmyEI4rmXU72ug2IhHR9v5Q7t6SOJvZWwO2nq504RFjetkhUAs5CX7o0NgTWyE68gcC3Jw+6jYRDaQhdDp0sk3+whRwmLE1+lP.re0pwAkPGC1o.XeINwcjP6ugtOF9erNtwKBLoz4vPhoKrbbGANMfmC+OtoHchWf76xVjD.TOH1YoQKOE.7Cw5kwkUwi8mp54LXEHguGv7wtij4kEb5hl2CqWf9W8NQRHW.1Ed4st.NRuShHuN177MoMhT30LqjT8nVdYo4oSXDZrJXKWR4EmHvu06jnFVUrOSdSwtQJy02zQxHaCvQP9ZorRBHpAhcNFFvIEim20R+abXsTqw19YiUwSGKVAEQ7QdqxjVOeOf+Ar6Fp2VWBmgq64S5bCXFUJ7ZlURpF1kWF5l4kFx1NNbF7Es8PyEicyUCAiCXF.yAXev5EVoyzsh0Kw+GdmHR9iZfXmiYR7VCoJMDY5BqGEpUYeeUqwi8iA9BsVpIIfdvJ.Q4wJT5f4yB7G7NIhbfdm.U3GQysbTrBh25wVdtAhOUC99eCriCuH1h882ixMxdLXU42cm7yZHVQuAhqK4q4D2WF+tQVi.aJgrgXy6rSzo7PBS2D1ZSsFUWhH0zmhFOl0O.rFH1MVuM93Cxq0qTie1kCLqzK8k5X5XeHf2y4gjLh65zYVXh3+wi1I1lXtel2pVjsS7zXmmaJ.OV.jOMajmF5kMqtAtd7+XbbiG.6FplUJMOB2Mr0aw7ZkGVQ1E2IZ9HJhTCcgMmkZzIQNlnmekWn3Pp50Z304m+RSw8AYflHvoh+e3SRG2Og07g6nw+iIsSrIwXebHXUnUuy0rLNFxuk0+qt1uMVHrs3+w2lIlW5bXX.VMrkvnGLC1mTT7h6mlajmHhzAXJDuSfrS.CEXAU7XUOrypWkN7Uvt6uR5ZUANdrds06OzIoiECrFI2gp11XwxIuOtzNwLav93Ffst54cdpH9wkWy2Iy+FFw6lYFRQslxEIogiU337d+TQ9OdVfUGQDIRbWbumJ1RJPkOVuXS38RCgl0oAuFZwYM8rJXCU3h7PJJNUZ2rz7v+iIsaT4RVSkVYfyH.xOEMebA038yhf8F+O11LwMjNGF5m3L8PTnHtwEhHwf5smNC6PLdN2MV4yeuq5wOTrhhQowud8VHsWAVOPtxMaBJ00zvpfluFv+H42Ey7F4DA9tdmDUXnXEJm7t2qp+euXyeoEfMWuj7mpeOsHXL.Wl2IQS5GmAai4jAaCoyQVMjnkbNUESK9FF1vSoQtOrF1U8PW59h95Pi9Z8FC6ecrpn1uC362D4nLPcCrQ.GB1xZPQ2cBbOdmDUYKv5887tJaLwr.NWfixobQRFEwFHtOj+Vldd8LXa7Wxfsgz43a3cBH4CpAhEeSgF2iSeWf+MrRgb0dcfGAaYT.F7gqFX2Yp4R9oTwGR5EXz.qDvrwt.9Nk0upuGvEQXcQucQ4h1Td26icyeNJxlgDmj9deuSfD1pR9rxr9mxfswhyfsgz4Xgdm.R9fZfXwWbVngKMrEulZ789T.+Ur0cqt.1y575LlnPq2Nwyn.1Zrdc8yPwcniVOq.aeeYdmHUYl.eZuShDxtA7+AqXzHECEsFHdvXyA97lr3lZ8RYv1P5b7S7NAj7A0.whuMLFOmsC3vXfe.82.adJsO.uMV0uJNC4t2tYRvNLiEaX9ssXq0ec5Wz9AgsvkGZNHuSfDzi5cBHItOv6DHAsF.eQuSh.1OE3qAr+dmHRt2mG323cRH4CpAhEacw.K5L0xfsnjuPrdODrKHYFw3056hs7KHkMergl6rvVS8DywC7s7NIpgIg0iahDpJRMPLuNTt+IjMWr8GfUa.TCDk1wx.tWuSBI+PMPrXaBT+gDZi76i95WO5qU26gq.aHkVomAqTJKlUG3g8NIBPWAgWQooj14uYDIKTTZf3r.tTuShVvAhM5ZxpQKyKgcib+RYz1SJdNdfeq2Igjenk4hhsI0l+7+snu9gXUuzKohu2oRsW9LBwgKXVaDX2s26G3obNWBQeIr46ZHdQtigNipFqjuEh+sSyparkum7n9nbiCypqi5dANmLZaIEK2.vS5cRH4KpGDK1Z2hdRkKoEyuh+8KA7O.r903m4W0layPVO.qKvjwF5s+FfeIk6wzQBroXqcdyuVu.BOAv4A7NdmHChc.X87NIDoAJBMPbyANIuShVzICrJXiPj+CfGOC1leHveO1xHUnN5KjvySfMkI9PuSDQjvwmDqwKsZ7XQuNSnpGeIXUfysqF+LiK5mYUR08rr2n.tMF3968hMwuuEr4dY6b7tnGK.aYWIT0EvCf+GmTnnQwbIeqWJN+s1FmvGahisCa4uv68cEgc7bD1elqHhStHZ+Svr5Xe.XkO1SgstpcHU832Rz1sKfCOs24xXyE+OYedNdVB+OnZZ3+wIEJhSrMjusC3+wvjHVB1TJvCSAanC58w.EgY7jjOW5Xj.glChEaaZB7ZrU.CopG6n.9CQeuJ8rQecFjOGNCeD5eQ2YTX6KGNp3.zN9ZX8l8a3chz.as2IfHwTnNDsiigBbVdmDIjqE3ccZa+FXCW+azosuDl9x.GZT75NmKRNllChEaIwPe4A.9wU8X6DVuHVcuD9eE80oRXtXrtyXyexUT0iuw.uFVCBKsDc7pn4hVR3i.7uC7mcNOhi43cBHRL4UiRRB6.EmkrAuWldptJhKctNQrJN+R7NQjhA0.whs2JAdMFCvNV0ic4.qECrH3TZYw3OB7KRfsc6XDX+9ckMFbO.9D.W.vAG88VD1PicHXSl6RTiCSF+ZxGMNbT.6k2IgHwTdsGDGFEmdO7qgOeN2PvFYK6FvUgZjXmtKA3eD0aghHMgKlrcLuupYytUCMLfqCqnxTZXTONfkhkmOMvBw+4HPmPL658FU.o54SqBEgbrxjOs23+wtjJlWBeroQVMrJj8Km.4th7e7f.a.hjRTOHVbMbx96t4Py3sWs19y.3SCblQO1a.7C.1GJ2imZgPOa7uhsLfDx5F6B8dPuSDQZB+EuSfVvHnXsFi9Cx3s2xvNO0uG3x.ldFu8kvwwisNKmmGp4hHNXsvF5jWMY6cz5.xhcNrKpey.NVfq.qPAbOnx9cHE2FvZLXuAF.5Fac77Fw+iUJTzrQOj+b.3+wsjJtvD9XSyZk.NHfWD+OVnH6hmijo3CJhzg5ZwuSfkEKuE0Z8WTQXDWIVu3VO8fcSL1brBdz1i0f+0BXjM3msU0K1R1xlALefGA+OVoPQqDKf7mwRwZnQ5wZeXsLFrymUZ5Snn3FOIvjQjLRWdm.RhaR.+FmygMC3G0luFi.aR3uO.eTr6b1OD3swpVWaYa95KIu8Dqp982pyyYi.tFp+72YYX8L7OA3MAdupdM6EqPMLLrFTNJfQicQn8D8Xk99SLZal2WXwkryJHrK7G+iXCi97jCghyv39ah84RgzR4zzA96A1WuSDIUrBr4y+u16DQDI+JDVP2Ok1H+GJ15Q2iG.6GJheL+Z8lYUVUfWI.xUEJpNddfi.qWrex.HepWbMjuLdJVC++8KYO7jXVYrajp2GeB8X9.aB173y6bItwtfHYLUjZJdBgpZ0g.bu.+oZ78FEvDv5km2E3Ch92qFVtezXC4PI785.WJ1PG6mFim+dhV9PjvxE.7Mvly1uezi819kNwxuuwOkfx7nXUPU99dm.Ch+.vMw.WVpx6NIr0u3+ZCddCAq37MNr0h4YA7wo+KGWuF1Me98vVemeIrJZdn5NA9hDuOeUDQpqq.+uaW8AbGXC0z0F6t0cTXMZLK11WG1Pvx6iAE437vZne8LFfcE3jwtP7kG.4sBEuB14iVcpsaO.xw5EG2fj2gnwisvc68wrjJtij8vShaKv+iQIYzNiFIvllAqCv9C7nQulOHvNS4gQ9cE.6mkxqCBXNXMvMslO9hHcntU7+DcdGuL1E+Mu.HWJZwiS7phZqMvyF.4qBEkhW.ati0n4W3WH.x05EGYCx+PxQf+GuRxHzab9XoXci3lYBdroaf0E6ueVPzwo6E68z0FqWt2AfqJi2GeVrd8UinOQjT04f+mTODhmBa3Lp4jQxEmMw6tZNAT4WWQXEGC1EOGGWd.ju0KNzXte3shVuG1G1BUen6nwlSsmL1Ho4zvtww4sJc5RI8ZzT2.qB8e3mVoIi0qi26fjaKBaTzrGXUz14fs1T1L6eOOvAh5oPQjTVuXCmhCA+OwdnDKG0Pkj5337v9P03nn0qAJxuwc.LMZNme.j20KhSAgJDTDOOvRvplj4QiBqxfuP7+3Xbh6KcNLzzFO14P1fnXhT60gz3dsWWO1x6zvS47VDQ.rB.xCgMTE79D6JJNwh.1PhugQ94BPTTbikfUsIakdf3zCf7udwAzB6SYshXuGVJVJ46kShIf0HEuON1n3bSqC.IrQfM2Aq2P68tA1arJ4sH4BZLOWbrE.GLvO26DQJTNXrFIFWyDsFUJ9YYXWX4SPqWsOeujKcREui2IPLLOrBsQQzoB7c7NIZC+dfKDa93ExMzcodm.MPuX2X9KDXap56sLrhey2Ca8780y1TSj1mZfXwPuXWHO.WrmIhTnbYzbMNDf0OMRDQZfkgMzPebf2rMes9Kse5jp9Cdm.Mv3AtZuShTxsA7UowK4Bgt2E3qPX2.wPe4lYFXqYpfc9mGBadE9e.7egcLVjbK0.whgIgMIoEII8LsvOyVk3YgHCtWEao84avf2ig8BrF.+Zf+VLdMe+F+TbUn2.whbuGd2j+abXI0ZcJNjrBuSfpr5XygyuOVC.WL1MDcEXm6IzOugHMk3VzIjvVQZQHV72qBrKzZKHzGXBmKhTK+PfOF1Mj3Ky.ab3vwVNVNYr4r2uk303PHrGhouJva3cRTGE4dO7qiMbAKJFl2IPCDZMPbdXmqoTQh5Cw96weKpwgRAj5AwhA06gRR4uCq.FzJy+igitYER567wFpeKuhGqGrxV+TA1NrEX6uOViUd0l70OjuXu+QB6FvVj68v+IrFETTrFdm.MPn82guD14Ud.uSDQxBpAh4ecS9np1Igsm.6ho+2H98zR0TY6VxBKDa9+r5.SAqzye.T9lS7MANynu9AsvqencgoUZgdm.0QQt2CAqABEIg9MVNzFJu+3nPjNBpAh4eSAXtdmDRt0OC3BvlCWsaOST5hwWF1Enu5.eg170Tjp8r03wtEfuK1P.7WR6cwkgbCD+ydm.0wGkhauG9c.9UNmCIsw3cBz.5FNJhiTCDy+TUiTZEq.3yB7njbUKt+LVE96wvlqF8hZfnjdNard9dIjrK8CsRuN1oar.eduShTziQ30iVEcyjvtGyEoPSMPL+aa8NAjbmKB3dIcValdXrg+G.iKEd8E4k.NBf+yT50Oj6AwPsQJ6A1P8snpHUbZxKTQTTDGoFHluMTrKTRj33FwV7d+Yo313gq3eu4o31Q5L8yvpdo+pTbaDx8fXHtFMNZra5TQ1uv6DnCTnUESEoihZfX91r.VOuSBI3c+.2LvKBzWFsM2xnsqHIoOGo+bAKjafXHt3auKD9E7j1wCSXuzhTTE5qSihTnoFHlusGdm.RP6qCbs.u.oa4Yuar0TqQBrV.6IvUkhaOoyz8B7syfsSH2.wPaItXD.mq2IQJ6gH6twZRYKuwOEQjzhZfX9Umvv5QZM2KvWB3emrY9T0C1ZC0AlAaKoy0CS1rNzExyAwPaHltS.au2IQJ6G5cBzg5O5cBHRmLMIfyuVeB+xTsjstVfMA3SisHgmUWn6GfFNoR56GkQamPqW5pTHkaCCa4roH6elzoXdIM1a4cBHRmL0.w7qwgsteIc1JsbUr1.mGvKSquP22N99XUwvIhUx6GA1uiNMfCizsv3HEe+q.KMi1VgbOHFRMPb6A1cuShT1+DE2gWpGeNQyPCwTQDoEzCVgAnOEcjwiAru.Sf7go.bO3+wME4y3rH6LtTb+nchWIM2oaRCA3ww+iIoYrbfUJoNfEfJM2JCwHj9ccQ5HodPL+5uhlyW4YaIvFg0HuuSL+YVFVUbbCwJ0+OAvuOMRtTva.bb.yE3a5btH4OYYOPGp8f3+t2IPE1ZrycUjcYTrGliYw74sUkVqwohHwjJRM4WqCvk5cRzg6gA1afuE1PQZbXCmx8LF+ruM1Zq0hvtS0++pyy8KB70vJVBucajud6CAV.1vQcGANGJ9CQMIYrjLbaEpMPLTlKb8BbhdmDYfm16DHkEp+dNjcCmbQjAgZfX9TW.GqiFVIFC...B.IQTPT0IgveCXSwZ3yuN5wdTfaC3S1fe18lxK9xabUeuWG31wlioKB3OjDIa.48vZT8yi0ihWAvl4ZFIgtrrmx+q.uJg2ZL6uy6DHxlicivJx9x.+buShTVHubtjWFYLhTXogXZ9zro3u1SkGbHXMDbjQQWXKtu+Kw3mcrU7u+O.NXrddbCvtvzqBqAhEsFGVo+BvSg0KhWmy4hD1x5Rd+unwOkLWHbQycC7Y7NIx.2I1MJnHKjGhoE4g1qH4BpGDymTuGFNtjnnYsnJ92KHgxk7p+.1vkdiowCO2aD6BaN6TNmjvw2F3cy3s4+cFu8hiPXcga1.Gi2IQJ6aCrPuShLPk8f3+Hg06q+IuS.Q5zodPL+YUANUuSBos7Cn9y4vNQuKVuwtaX8f53AVYf0DqGF+JXKoGmI1bWbt9jl4B2IvGGaYHXCAlJVwMJuxiEp7rbNOFWgPY++H8NAx.eABqkSjzRo8wU.726YhTCcBG+EInodPL+YZdm.Ra4qf0.mh7PGsU86.d1pdr+H1Eq+cAN.r0Ww2graQSOO4twFZxuVM9dgvvSrU8+3v1LTlueUx6dUYl.mgy4PZ6m.7bdmDYj2L5qmOvh8LQpgh9v6UjfmZfX9yL7NAjV1mBasmJqGtbEAuG1wtdh9+CwwbwaOLVup8GAFEVA94n.tZpciCAa9dlW8lM9oTH1lMxJbd62Iz6gWIve16jHiT5lT90wtoauFvz8Kc5G0.QQblZfX9SHW4wjA2QisTXHsmRW3vp3ZVj8tTr0Ox+SF3RcRW.WKVgRZvjmuoDdL26Bwhjw6331dCv5oohrkgUck6TrLryq7q7MMposD398NIDoSlZfX9iGC2Jo8sU.ONgQglnHXNdm.YfkAbdXU505stf0GMdgkNO2Chdr1eFh+cpW8rUW.GmSa6rzERm0P++GgMe3KYU8JQpgc06DPjNcpAh4KyA3H7NIjVxIgU.VtFfeC1Er+cwVKEklS2XyGwhryA3dH4Fpi44h9fZfnwqdAdS.Ncm11Youg2IPFqxBwT2.iwqDoFzMBWDQhodwVND5SQgIBk46QdyLw+26Rq3EvlSgIssL.12Z0X0SgiGMx3Zi7MMhkiOUc7gfciJ7d+OsiaNoNfkSMJ7+8fJi6Nc2cEQZD0Ch4GSC3i3bNHIquBv2A6CD+4XyEj2.qGF8nWSxK9ndm.wvk.7uf0SwyCa8arQ9m.NKRmBjx6mBulYgWCep.qq.30wVhPBAOG9LZC1Kr4OcQ2W06DvAqBv9B7zDdEElPrHQIhHAo4i+2UOEYW7H.mL1582L.FFB.qFVuo386OCV7JXq+fUpWfasA+beAR2g3UdsWWiSCqSK2ecxqrN7nGtlD1vPz688zNVJg0vqLqbAX6+6A1nYw62GpLN4Tb+VDIFTOHleredm.Rl5iEEk75.2Gv+FViP9uIeWYJaUG.g6Ey8CANLfeYUO9GhszTbRCxO2YCbKjtySv7Z0O9m5319UcbaWs5UjhRCciMuCCkdPMMc43+RHhG1.r4c4O.XJNmKUaIM9oHhHRnMeXT3erbrdcZew5gwNga1SH26gOOvZUmbeqhddKD3To76gGLkWaGSSSC+OF0JwbSgiEw0wVm7JqiSIk2Wq1djf4dnGqQBcLKuYx.qbz+dV3+6CUFaUZsSKhDOcBWTYQPm5GfICtw.blQA.uDvCf0KVKhhY4Z+iSX16geOfCG3WWmmyZE80S.68pmDaYKXYoap8+5CynsSR6MbbaGRGyxxk3h0hNmhDxkPmauU8ap3eGZiFkeq2IfHc5TCDyGVGuS.I3sYz+pe4MfU7AdYxtFgjllJ173KzDmFG1KvQA7+E3GG8X+WobdUsPqHTDWY8PqLT8NYz1YT.+czYLzRA6lpI1nYHT7RnFHJh67nrYKMuM26DPxcNCfmA6BruQfcB6h+xqNJuSfAwwS8abH.aHVkL8wvu08x7XCD+tnp4aIYQCD6BadxN+LXaEBNGfE6cRDHBoFH9vDV8duHhDj5Eqnj38bBPQ9OVL1E.NKxl48VRY8w+ic0JNnXl+WDVC0WsVZuOYLV7+3UyFWRpbjH9NZ7+XPoX2R2cU.X2cb+yiXMSlCaEF2A9+dRe.aWZuiJhHEASE+OgshhW7n.6CkKRAgptvFtrde7p53JHdMxdkhd9Gbqd.HgLT7+XVyF6SpbjH9NZ7+XPoXGR2cUlJ1Mwv68yrJdHrysHkcz3+6KOHZpOIRPPCwzvWmxbAQxVGHvSfsHjeE.aAvPbMipsME3y4cRTkuFv0S7F1lSD637SjpYTi89DVKaCMxKgsjtHl+RJ9Z2C1PR2yd3Nq8vXMHQJKDVqc+sngWpHAA0.wv2Z671eEX2I+4gstX48E5JIuKDq5m9DXCaxU22z4+0PvVi.CI+Drkbf2JlO+O.6uaBgpD3K6cBzDtBfem2IQ.IMWiL2UBuaBSZagdm.AnUw6D.XDdm.hHRdw0fuC4ipqbjcAr+NmSJR+35A1Yr4tlW1lZjWdFKGX1o5db55Nw+igUGedr0isUA3Eq3wCgJ27Qi+GeJEqaJsONA57li6WUhbjq3IDlChuHpiKDIHn+PLr0K1PAzSUt9aMafuJV0XTJ1NCfuCvu.qGvVGx94rydjwau540A1Sfep2IRAxm.6Ff8a.dS5+w1euKYT+0m2IPEd+T50cK.VuT50NT8U7NABP8P1THjZjMCaX4Kh3L0.wv1pf+e3ck2I++SfaB3a5TtHYuUCaYx3W.7EA1RxlJf5XANqLX6DGmG1eG9BdmHEHmF17.avV1ORy4bWbERKMHo0wisJkdcCU+KnaxSsLNfo6cRDYq8NADQTCDCcgPAp4.obwK4CA9+gMmDmEvwhM20jNCmD1b241AlSJuslMvXR4sQb8yHLlCgEIMZtL+AYRVTegTwxHM5AwQBbDovqaH6efv580PQHL+CKQMPTj.fZfXXaZdm.QpdAV+CA94.2MV4WeiwZ7vKkw4k3iiCqfmb7.COk1Fgvvcpjes2IPBIDZzUI0qH+75DFWDeH0ChowwiMG+GgJYoWE366cRDnlh2IPEBo+tSjNVpAhgsMz6DHR8prXuOVkc71wJpHaHvwfM+0jhs+AfaFagrOIMQfKMgeMaUq.3W5cRjP9Cdm.U3HwtACithG6ch95hx9zolBgFoVRReQycAbHI7qYn6JA9SdmDApo4cBTgE3cBHhnFHFx5BaokHDD2dI5CvFNd2Cvtic2oObfudJkWh+NNrdS9pv5QhjXsTbOSfWijxGmxMbIu6M7NApvMArQz+KX+GE80eP1mN0TH0SFIctrIXi5iNI+qdm.ArMx6DHxOA0KuhHRcMA7ujSWJZ2pJV2X2gxCB39Bf8GEoW7LQuOOYZMigvor6GRCy0jvdi+GSKEKkAtTVryQeuPo50ta3+woRQuI39Uu.2a.rOkkwmOINvUf8B3+6Q8AbKo8NpHhj2sQ3+IqKEIcwBYRXWr5ME.6aJRu3N.1NZtdU7iF.4ce.mBY+x5QZaUAVB9db84.tBfMsF42XwFd5o07ZsYsk3+uGVJRxQ6yNF.6OYcLqD4HWwznv+2eJEWeJuuJhH4dgxEJe6o794Dv54fKCagH268WEIe7jXq2ZMxP.dp.HeuSBmFojz1O7635sCLrzeWLwLS7+2E6Cq2VSJCC6uG8deJq+8th1M6IIMY7+8nRwMkx6qhHRt2oiumndWA1Wx1BkyXvJzMmEvhSn8CE9GuH1EoMWpusN.x0mB6lVTT0MvYfOGaOtLX+KIsl3+uO1GVECNoDRCy3rJ1rD4HWw0rv+2iJEKk9W3pDQDoJOB9dh5UK82EqqQfUHENAr0dOu+fKEsdrTrgZZ8zEvs4bd9xXMJnnqGfqkr+36yQ6OelyRSE++am9.d1DZ+Y7X2rFu2exx39v98cYvERCk59HrVSF6z0KE2QSiz.ZXWDlFE9WNtWKf+amygRFBVAsXKvpJpgTUtThuyFa3at7Z78VerpgpWVAViX+ObLGxRaDvO0gs62C3TobEKMjMUr4ro2dBrgFb65TwVVZ5jrcXEfEYvsq.eKuShH2M1MENjVhYxiFI1MYejQwnv5Y1wDEiJ5qkdrUBXMh9Y2bpcGD7C.9c.+Vf2DaTd85X2.3eIveNc1UDQpzLv+6h2yfchkPS2.qMvGC3Av+iSJZtXA.yd.uqBmmy409VibpHyypjbZOulSJgROH9HIv9xrCf8irNdTR1p+ZQ0Ag+uWUJBkk1qPUOXMlaZXivp4BbfXMp9hv5w7EQ1+91RvtAvaDZ4ySjT0Ni+mntOf4j16nsot.lBVA84Nv+iWJhWrb5eQqYhNmOWMcdCCsUEeOlmGlmmEkFHNF57JLM8QwaYpIsbz3+6UkhKNc2UyEFI14d1Tf8B68mKD6FhmGJjeO.VkRNIVSjEQpxwfu+A98S97CXmHVQXv64xlhFGKBatlrg.moi4wBIezXkjl2ElhP+lOAvpi++cRezdMPrafKH.1Gx5XQXCiNow9L3+6WUFwohWWDrRXSshcAqQfWN1H2x6i+IU7vXEcP0ihhjftY78OrOXrh0QRu9GlkVcr4p3sh+mnTQsi4ALe78thtkzYx6gU19m96hsst.dP7+uSdr1Xe3iD.4uGwQzFGy5zbp3+6WUFmY5t6l45BaN8skXed2EgMUK793bVEWI10iIhzlFB1j906+ntVySr7pUCXOPMVLzhqDeuiomDct7nJlVY74S+cwDwmD++6jkSqUIAWCrJyq24uGQdpZ45syA+e+pT7bj+Gt+iEXcwtliyFaex6iqdGuB1xXkHRaXZ3+eLe.XS9479IpqkIi06ION9ebVgewCgUk25T8X36w+mL82ESDaA9+6p8gMmjZFyhN2FGdpM4wpNcWL9+dVo3NS480jzP.lDVU+7.ANWfmF+OFFxwASw75JKjTE9J73cO28Cvt3sOjh4xfxuAq5180vV5L1Er4nSydAXspeB1Pn42hMGDVSfcfN6dyJqsLrpl565ch3neL9NLOyKyOrWy6DHRybyLVYfuD4i44YRaEXy8II9Bo+V787NApxHwV+Pm.Vg8ZRX2D+Yi0XGo47P.mFVch3u5btHRti2y+vWlNu6vyXwJtMY4xlwsgszJrQXe.zX.1.r4Nyhyv7nSL9nH8B7wwu2CVP5uKlX7rBf9xXmWZrwLW6Fana68ei4Ubnw73jTVHUT2twTdesVFBV0PeKw9L4S.35.d9XjuJZs3fh06LhH+uFNgQYLdcS6cz.UW.SGqQZY87F3Uvt4.2PFuc6zhOGpppUROXqaVd79vSkA6eIkyF+980MtIy0c1wb06X4X8dpzbdD7+8tRw8lt6pLLr0Y5cF3SiUWBBgZ9PmVrbr4HsHRLs13+e3daXq4Nc5WD8PvFhVmL9rvypH4iqFXnHUZ6wm2Kt8rXmKgru32uyN8lHOGO1x1h2+clWw41DGqDSuDF2T5RwBR38uUB6lrb..WApwfgTTzpVshjp1Q78OXeVrKfdbXyOOwLbrEs1OK9M7OOSfqAXINs8y6wqf5cgZYn3yPnLOsLDrw32u2tVMQddtNlmgP3872OOZkw+22pLVNsdsOnGrZIvtfUnhTAiI7irp1OHRt2ghu+w5kl56g4ei.atJbNjc2Mxqix870PwFhL6czi68I3yKw9Mf2IkR1axl2CdArBxzzo0V1F7xpie+d6ZEybLTp1pdE2IZTuzJlM9+dW0wHiYtODrykrGXEcrWL.xcEMWbxC3cUIXnpXZXw6ds6Ccd6mG7t.+vn3Vw9.1cE6t2OlTZad1X8t7yA79.uMVOhceXyYwoArcXmrsYFRZcJdBr0aQo199XU10UKk2N2MVgeHu4O4cBz.iF3p7NIb1W5+e6cuGjcTUm.G+6jjIjDHj.I.gmBDXIPDDht.xq.rv5BZ3Qb4gBBwUPE4g.JHnBhlhmhRAn3JKVlZYYofxEnTjGZQgqhabwhcEWikQMTnAWdTHKFT7Mr+wuYbtyj6L2Wc2mt662OU8qFxLC8824dN2d5S2mG.uRpShJnNcNtVDlCvKOlu2jHFtnaAw0I85I1iR8u2UscQDWGyKk5DQprK0CIhSK+Kh0VyjX9b8woXqyVIwxuMDOcy8lXSHuLMuRRc3JlVq89I+qGtMh65eUyjIcscWPajeKKg4WYHVM826oocq4S4b90eh.KB3v.dm.WcIMOMxl3PPRSnoR5+fpK++YiYQzYwKghYXndULRmDG1FS7TGuxB30urG6USqkTiV.EScw4Q0bjqjpk798qE40rw4k74zh2iTyUz2LSCilE2L0y8baoLSYXxh+Fx8RY+mMBXeHlyh44ExsFfSglOLAmCvgS4Z+tpHhq.3Po0Wjshgv0sSwTubAz96qekEoZ6.YIsHuR4dYYYIZmmxpFsYhixDixSr8How0qgz+gzTOGHq6lAQmve+DCKp7pd7RHFhNMaKcXKAdqDyIuT2dKOiShXnAp1WQtcN7koZMr.S09S5wOA4zzwEliUfKNMcix3hSiQ+abpHow0tR5+PZduHUnQLMhEHf2G42E48MANAfspIu9CRLzKuzb50NkwYiWzX2XdTr0SmTwTrxDWNoos7oNA4z9knbpLEN+k5NuURecmgwvwiP0b9oKUHR4ds0vwVl6kR0LSEXgDKRP40bc5JHtqwMqiSaFvwR5Wjjxh3VoZsEJT1biTr0WUkmh3Gkzzddh1LoupDkSkkXUz9aIBZz522yLMJewdfjZp8lz+Az+1buTpVYJDyolSg7YXf9EHtYDMaRgOkg9Yejb30sHh0gK648pCihsNaKJlhUO6BHMsoukwIe11DkOko3cNNu2nVqnluwFFsa3hMkz3nLrQG+n3jEtLYxDyKzSjXNakk00KGXSlfW64RL+mpRywoSscdSUSnMghsNadESwpm8AHMsoWSSxkoR5FxqkoX6Zx6Mp01.bApwn7EqAGQ.RMUpGho2Nv6hXyV2wBd4yj.1AhUsv6froNekDasISzv7aFDOY46MidMyq3wn5sxXVVsbJt5spRGDeujt11Md93ymr6y+U43ZFuJJ0RaGou9yvnYw9hjVOodHltK4eQTYjAHFhYGMvWjdut+gHFZgavD7ZNHwBBwCmAud4Q3viN6bPTb0aMaATpL5XIcssG9F3L4DlCksv4qT26MR5q+LLZVbYHo0SQO2eFa7ly+hnxIaIwSB7yRu0F3aRr51MmI30ZF.Kkx0ly8MP0byWurZVTbCAscnfJS8pTNBOFtChyIg4PYJtYbUJtW71H80gFFiWroHoQ43Hsenbc3cksNXtDOoudYNJsNfykX9O1rEyFHVbQJCaQFOKv1zcuUoIPQMG2pJax4Skzs2gNbGDKCaERkgXumnJJ0RN+UMJywggjFkxvxN8JAlYdWPUgYVD6UZWDc+S76lHFRRSsIG+A.d8.eot7XmEweWO8NjFOKlho9auJpBTFX2IMKtGC2AwCLAu1ks31vQKPuXRTsV3wL5+haBI8Wr.R+P1aEDOMlsMeKpJQlAv9.7go6tH2uIwS4dyaxwdPhKd8t5hiauDmKi+S3T8lYSwzYnpxPaeCIFNrG.E+B1zvcP7jK3W2xXrnIrVRsxVS5qCMLZUTU19ijxcyjXNjkpgvzkRbmEmadWPUovLItP2qgtq8xGk3ooL4wbbGtihegt731IwMvDun5ndWdLTzdTF8pv44UXkldyYvH47pI6eeYhhMkX6G5QK3W2xVbc3MDpWc3j95QCiVEtnyI0fIQ7n0SwGF24Bn7oxosmXqM4Yoya2bW.GAq+vRd.x28MtG.mH6EgES9T+cXD64UC2FpJbQ+mNo6hktQhg+epd8KKgO8vtyrINO8xwgWpQ0HVNR5uXaIMeP7wv4zghMH8kB7Hz4sgVMvxHVMUg3B9umt33ztw7ygxuVeyl7o96D.NlF92UgUxz2.o+hl5mi6D+6TcpYCbJzc27OCiTEqi3lhIogjpkQ8OQQT3TkwzH1G7VAcW6oOBvg1k++1NwCjakb0L4wvL8zHlKqC+uO4Bqzz81HRyBTiQDGTqqhzP1Hh4KdQOTnMLxh3wvoOhznrXRyGF+vEQgSUNSBXgDabso9OXzX3POoXkGmW5JG5XeqC8uWEvlUHkldymhz29ueLtOZ9pnrFs4Bbh.ONouNyvnWBmChk.tYyVdLsD855e3UMyqPbg6WFw9L3oA7ToLgFxSm5DnOyiC7bY7w7HI9aOe8g926FvYQ4+uG8ej5DnO00A7GRcRThsC.mCvS.b639Yrp91nTm.p7+Gj6mLXhdccSFWsxufXkIcg.KgQtv9THq6rhlXuHwvFNKsG.yg3FPLrKk3oUVls5Tm.8g91DyKZMZSgXZobUDcL75w8vXUe34ZkZPiKZCEY7nEQgS0JSEXeA9bT7sWO5Bn7oQadj80i6dSNtqlluOaVVLSR+PupeKVRaUyz+X3UjzhdOm0vnnhal0eKzRpu1agz8ARGlopaL.vt.7gH+ZadmDqfjmNwMy3CTHkLMVmOYa85Q.Lql78uvhp.0kVEo+Bn5WhGGGpYPbd1+JhgQpqHoF08X2PRixahz8AxYW.kOUuskDKfLYcaySngWiIiCipTIq2FdVFwMlpY+rcrXJRckUP5u.p9k33ZupjZqMkXOC8KR5qKLLJhvQLPIh6qPkG+wD9ZOch4ZjT25oIeV.YZbgA4OC7R4vqgZs0Bbl.e1L53s0DK7HmEw7J8Na3mcDY3qSV6IScBzm3oHsy04TYPf8jXOo8hRbtHk2dPfeFvuC3q.7PoMcjJmVLo6t1rSEP4S0aa.Y+xq9GrPKApU1Txt8Vsaqgi6abL+rGgXX0UFk0C01Fiqlni3o9t3WFhSscqPpIFj3oEduj926MLxq3wH12a2UhGLgJw7IHVdjxmf3FlvWaUOrKjsKu5eKfaICOdp28BDcP5dyfi0aG38R7DgW6X9Y6OwEO7xYvqSV62lCGyuAv6l3tneF4vwuJ59ScBTfdM.eRbH0ppiOCv+Cwn5Y7rNfeMvuYn34IFkQtk0TQXGDKORYGDcdcod0AjgGqWB38fC64xnuFw7vaYYvwZ6HVzWdJh8YyaYL+reTF7Zj0xiySeKDCc0OCdtX.tD5e1NalBvmmXMHPJO7ORby35V+PfuOvOm3bxqF3+jItygRJC85HcO1+2bAT9T8UdL7ROjBsDnNwNRb2g6053k1vwbpD6kaC+ytdfYj+EkN14P1e92qhX9cl5g+UYI5m1n22PR+62FUy38AryDCM8I52ao.yG3FZ36cY.GIwm01QhsWnYOTLcfoMT3dktTIvNQ5NQy6n.Jep9ZOH6ZKdq.mHwFotJuNd5855amQOWC2ThmP4v+76.XKx+hRG45H8WXXcNVI8eiroGlz+9tQ0KVLiXaIVbuNShNLd8.mKw9U7vedZRDy8uClx6b7VRMwVQ5NQyYU.kOUecFjMsCuN5+t3vppoR1rkOr8i43tiL585sKKOKDcnYQ17jSMF+3bZ6Zi5iSiz+9tQ0ItSfCD6jmTeiYS5Ngy4U.kOUOMUxlgW5ZItIIp5XWn2q2Oolbb+GFyuyljmEhNvdS5u3v5brVfcnsqMpOlOo+8dixabODqn2Kg3yGSFI0WYxL56bdQFWXAT9T8TVM7R6kIQuRmKldqdeUr9KLKyAXMM76ru4cgnMMef6izeAi00XwseUQsykS5e+2HMw8A7oAt.fSgnif6GwnovUXdIA.+yjlSP8QJhBmpkdujMsA28hNwUlXKo2269NplbbabQa4Ly0RPmYaI8WPYcKtSfcqSpDpg7oHVehmkXtzeE.mMw992RHFVn6Iw5MwVArw3TpPRso7bSXdhhKnHJbp1YPhM91ds82iQLTUU0zQSuU+uRh42WiVRC+7qM2KAsuA.d.R+EgVWhUPbgxxUx1pVrFfqgXOcceHdheaBNDPUMg28hxkePhdcyiM+YU+sS.KJCNN+S3lmaU18QTGd5c4++6KwPq5Fa368BM7eWld5RuJvWG225xJ+qDK7OJdpSm.wSZRkG2OwMw7IA9Y.+uDme54A9SoKsjT+jsjQO2aJp3cWDENU67NHaZ+4vKs5adz6KVQKrgi2VOle1bKhBQaZoj9mdQcI14N7895t8kzWmzOFOFwVCwYPruPuHfsgXOATRpTX+o3O43IWHkLUmLIxlEri6EGdo0E6C8VaguLvF0vw6S0vO6HKjRP64PI8WPacHtEb330LWDoutotEeMhEBlymXHgdnDKvZaCi9bNRRkVa.wJ6WQdxykTHkLUmr8jMs8NfBNuU9ZYzasGN2FNVKpgu+WhxyThHE2Du5TrJhKPeFc5a78INbRecTULVIvxItg2GDwSmdSn7bdCIod1mfh8DqKtXJVpF4Xo2Zy8HDOUnIUzItxUSE3Fn2Zar+Mb7VVCe+iuHJ.sg+ZR+ECWUiURrhcpla.hscpTWOUEhu.voRLxElG92RjTefiih8DsughoXoZjUP22d6YIVw2T8zbo2F9wqg3ITCwc++i1vOa+JnxvD40Q5u33pXrVfcoKd+tevR.deDKTSotdprF2.w7+cWwgEpj5ScfTrm3cWKlhkpIlM8V6sxz7IS4isB3go6aibOLxVewz.t5F9YGQQUHFG6J8V6+90vaD43aqIa1xfpSwcQLBB1KbqPQRBHVUGKxSDu8ERoR0EuV591ZWKtvTzuX6HFRgcaakqjQl+PyfQ+zU1yhpPzDicEV0n0gaKHs11QLrISccUJiGB3XHV7XFn2d6TRp9onu.jsnXJVpl3nn6Zm8rDakKp+w7o2VzsdmMbrlAiL+rWEwETmBSmzegzUo3s2cuM2WZPh0DfamzWuUzwCgKbQRRSnAItX5WkXE45.HN4Ydch4gGJWRsiKgtqc16HEIqRtEPus+tdPMbrFjnSiuJvMWLoeS0u+jdZ237vEOjtw.DOEskArZRe8XQDWRV7FmjTc2mk3jlC24sEP9ch4Tia2iB..HvVRDEDUMnHJPpVXxzcyUlGGuQD8y1U59mj3ZY8W4K2FfcpHR7wwQS5uf5xd7ow+1RVXlDad6OLouNMOiOTV8FljTc16h3jlSen+8jI+9CDtOAo107n6ZicboHYUoxNQ2uPb7.D6oYkEyfQtIdFqebKDcrQYmoSL+75kmFeYNrChRRsgCl3jlMdQQGC4yIlcH.o109Rm29ZsTtt3dkNaKc+M55Fnb8Do1GR+EUWFiaiXkNV4i4Q7zYSc8bVG1AQIo1vvKTMMNr7lBvES1ehYo10oRm29ZYoHQUo0VS7DA6lyUc5IHeGO6Ho+hpKawZIF9uJeM.vBAtBRecdVE1AQIo1v.Dm7erK0yCBbgjsmXVpccyzYssVGvlkjLUkYyA3xo6NeUYY+zaPh12o9BqKSwg0SuiptwlRrFEr6zc2.uxRXGDkjZSi2P+bR.uExtSL6bPTsiMjNus0EljLUUAShnCEc57RbkDcvrL39H8WXcYINGb5JTFTUW.krChRRYjyfr4DySqnSbUIsKz4ssVXRxTUkLKhm7Qmrb9ewIISWe8i6WcMK9D.SsGeuTYiAAtWReahNMrChRRYjEP1LDmrChpcbjLRal14h4uChUeWo1wFBrmDK9KyA3bYhaesGoIMGkOEo+BqScrLbTnT1jWKnc4YXGDkjxHaMv0SquPpIJVUgm0pp5hHZybgDc7a4LwssNlzjlpF40B7wo4suVdByqgUUGNeYQrVfCr2eKT4fp3BnjcPTpDw4KP01FPrARe+8vw3QynbQ0eGIvOlXgp4OSr3HLQdhbOiTc2O.3iQrsIbP.WBvCBb2.+vDlWC6AobzQ0h18CrXfuUpSD0T+bhyUKIo9PymnCdSlNeNG73D2A32Sgm0pJZiHZ2bMC8umAstM1bK9zTJIlC8OKXMWMtulVET01qD8IHJUh3SPrZ6Y.9xDOMmULN+N2MvKMlu2wPrTw+FAtq7J4TsxvqZjOyPecvV76+eA7KyuzQpT4WBbmoNIxYuDvQA7gA9+RbtnV6Gj5DPRUWNwxq19M.W4P+2emg952E3qCbhDyCgyhX0k60RzQxeBvOcne2mpvxTU0M7SC7ka3qOEi+lh8+MwcEVpewym5DHGcq.WJvSl37PsumM0IfjptrChUe+4g95SArTh8HrmA3SBr8C8e+J3eXW8lMenu9hC80+HwEMNda2.dyGT+leZq+UpbdNfyG3eC32k3bQcl0k5DPRUWNDSqWtaFYH.9h.eOhNGJ0ql0Pe8oa368yG5qmKq+BRyh.NDhaZgT+feDvGL0IQF5rIF4I2F14vpnwN0RjjZa9DDkT6XiG5qM9jAG9+9OArDhmn3hF56sjghSqPxNoxgaDX5TcVYSeJhUjzgGN3OCv2mXJK7KRURoLwuN0Ifjjjp2NafaBXfF9dykX0v8PF5eu4.mIvpIVgbOYZ8hYiTcyT.dqj9UExIJtWh8vvMLmdOPo2VR5am4pXpjjTM1QBrfl78a1nPXRiy2Wpex7AtAR+Ed+pDaAGWLQGWWHwBWlp2lEoucmcPTphZfV+qHIIotvj.1CfikXU.MO8UI1dYdBhgG5yQrxp9B.+1b90VkOSgXwDqp3hH1iMkTIf2keIIo7wqPrXg88.tVfc.XyHd5NStgeu8jX+ErU9p.eahUL0mgQ5.3KB76yrrV0A+IfuAvAm1zPRRRRRci+FF8Ptac.edf2FwpIpyWP0otIR+PG0gXpTEjOAQIIoz6gAlGvz.dYhmJXUZHBpxmpz9QqS4IoRD6fnjjT58J.OapSBUq7boNA5.St0+JRpnLoTm.RRRRJy8BoNA5.1AQoRD6fnjjjT8yKl5DnC3HZSpDwNHJIIIU+rtTm.c.6fnTIhcPTRRRp94Wk5DnCL0Tm.RZD1AQIIIo5mpzPLciScBHoQXGDkjjjpepROAwMO0IfjFgcPTRRRp94O.7URcRzl1gTm.RZD1AQIIIo5ouapSf1zdfa0ERkF1AQIIIo5oeTpSfNvFj5DPRA6fnjjjT8zZScBzAlYpS.IErChRRRR0SUoNHNqTm.RJXGDkjjjpmdZfuQpSh1zrScBHofcPTRRRpd5U.t6TmDsosH0IfjB1AQIIIo5qpxJY5hRcBHIIIIIU2McfGG3UK4wpAFLmdOPRRRRRRC4nH8c.rchcJudCPRsOGhoRRRR0aOHv+RpSh1vdk5DPR1AQIIIo5teOvk.7DoNQZgcL0IfjrChRRRR8CdRfSJ0IQKr0oNAjjcPTRRRpew2A3Mk5jXB3dgnTIfcPTRRRp+wWC3sj5jXb77oNAjjcPTRRRpeyWE33ScRzDuXpS.IYGDkjjj5G8k.NkTmDiwuJ0IfjjjjjT+pA.NQR+9e3vwee9VbkjjjjjzDY.fiiz24vWEX+y4xpjjjjjjZCGFouCh6btWJkjjjjjTaYu.VCooygqCXCy+hnjjjjjjZWuFf6fhuChWaQT3jTqM4Tm.RRRRpz3WA7..+XfmC3wAdYfsKmecubfeRN+ZHIIIIIoLvT.lGvg.bMjcO4vOHvRAldwUTjjjjjjTVZg.eN59NFtFfcqvyZIIIIIIkKFDXYzccPb+J9zURRRRRR4s8F3Qo86b3RRSZJIIIIIohvb.9Xz5UpT2qCkJ4FH0IfjjjjpEF.XO.dy.GNvVAbO.+6.qB3mktTSRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRUa++j6jHcOv16e1.....jTQNQjqBAlf" ],
									"embed" : 1,
									"forceaspect" : 1,
									"id" : "obj-77",
									"maxclass" : "fpic",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "jit_matrix" ],
									"patching_rect" : [ 128.29998779296875, 14.007445335388184, 152.0, 65.911504424778769 ],
									"pic" : "rave.png"
								}

							}
, 							{
								"box" : 								{
									"autofit" : 1,
									"data" : [ 8126, "png", "IBkSG0fBZn....PCIgDQRA..APO..D.BHX....PpFZ.5....DLmPIQEBHf.B7g.YHB..eTWRDEDU3wY6cuG+kTWWGG+0ue6E32hvBHWzX2kRAVPItlkxMyRhKlQp.pUVf30REUP7FHjWRDDwn7FZpkJpDgIfZZdAHLQ4VXDfjJKTJKnrrKBHK6s9iu6IVVNyuemKyLe+Ly754iGe+CQX98cly464y4Lym48LAv7QsA6AvoCreav+reBvaC3BAVWNlTRsbSB7h.dh.uWf6MuSG0kMAVPuoaa.NYRenxrJ3emqD3MBb800jRpCX+H8kn2i0++9mA7N.9z.qMWSJ0cYA8lq4.7RIUndPdMbsj9fl2AoO3QRilE.71AdtE7++0C7l.9N01LRhGcA8UCrpLMWzf6P.NSfEOB+2tBf+JfO.9ZszvXJfSD30CLuY3e20A7OB7V.9ep34kDj9QdL+MXroYc5nYxt.bIj9vhwcby.Gd8N8kZjl.3E.baL7qytefSkY9K.HMtlBrfdSv7I0vMqjxoX9FN9xLZ+Reotf8A3xY7Wmca.O+ZdtqtEKnGbSB7R.VJkeg7Mb7P.mE1OER8rc.eTf0P4tV6x.16Zb+PcGVPOvN.fqgpsP9FOtSRMZ2j0v9mTDMWRWi7kS0sNa0.mKouzfTYwB5AzBA9rj5J85rX9FNtVfCrp2QkBlCmTukTWqytGfWGquYljFSVPOPlhTHvb+juB4a3Xs.eNfEUk6zRAvhI0KI4Zs1MAbXU9doZ6rfdPbz.Kg7WDueC6RW0VMeR8NxCQ9WmsNR2AK6RktGq1LKnmY6EoljI2ePxfL50ktSTIGIjpOSRpWQtSx+5pMdrRR2QK1fpZXYA8LYaA9HjZNlb+AHC63xwtzUMWGHodDI2qilowcR5NbwFTUCJKnWylColf4dH+efw3LVC1ktpYYQj5Ijb1roix3ZHcGuHMSrfdM5PI07K49CHJywxIcK9XW5pnZd.mFwoYSGkwZIcmurvx8PiZYrfdMnLiq0nNtYrKcUrLAod9XThq0nN50fpSUhGmT6gEzqPUYbsF0wWBiQVke6MkSbsF0wRHcmwHsgrfdEXRfiipOtVi5vtzU4x1Qp2NJ63ZMpCiQVsgrfdI6..tZx+B8HLrKcUcYNT8w0ZTGqlzcLy1N1GEUSmEzKIKD37n40As0wvtzUUo5NtVi5vXjUVPeLEs3ZMpC6RWU1VLod1H2u2NZCiQ1tKKnOFhbbsF0gcoqFWQKtVi5vXjs6wB5ifnGWqKA3cAboAXtLcyQ6RWMLljTOYDw3ZMpCaP0tEKnODhdbsd+jN8+a3u98n.t0.L2JZXW5pAwARpWLx86WKZrZfUEf4QQikR5NuwFTscyB5CfnGWqyz0mdJfSA39BvbsnOLztzU8yhH8d6n1ro2CvqkGtQzhdZPd0XCp1lYA8YPzWfNLcP9B.9LD6ObztzUPJtVOUhayltZfOL8+Kg1D9A.mG1fpsQVPu.QOtVWJi98389SruW4sKc6tZBw05kBrmCv9RS7RzolMKnuQlOvYRbiq0xpIWlD3ESrSyN6R2tknGWq2JodRYX0DZhVaP01AKnudMg3ZsJJvsEzM9BLJthdbsdej5Akw8WxF8ay0KizW9PMWVPm3GWq0wofdmAt3.ruVzvtzs8I5w05ZI0yIKnD2midPTYCp1r0oKnG83ZMGMIVzaBP6R21gCiXGWqWModMop3m8npPmrfteK4o2bHcq3XW5pxVziq0kRp2RpqyDzAPru+5uIReIe0Lz4JneTD+qiUTBZE6RWUVlOodgHx8pwYRpmRpac092QkuNSA88BiB0QkG6znpIDWqWLodHI27K8nwUqufdS3WYdpzL9UlQ+raboXW5FIQOtVuQh4oStIjAF1fpwTqsfdS35.2DebhZ+GnYRSKtVipCi32fpUYiCpgWqrfdz6T6gItViplPW51D9P61jon4FWqQkwHqFFspB56Bw9do9NYziq0npIbO7GwSqZaSSHtVaxWNllvkNzFTM+ZEEzMsyxqlPW5FkFepsYuI9wZ5nDWqQkGu0zoQWPuITHoKc6dXW51czKtV8WLlGQOFYuTZ1mQjlpFaAcehgEWMgtzsNCOj1Dultwg8rf1XMtB5MglwxHSLwtzscwWOioEh2UAJowTPuIb6RctjNUj5g0D9Eck8Cfi1llvYbw6K53GirQ899uMoQTPO5AZRjhq0nJ5coaY8HxrMwdhn4wj4qaKzEzidjidajtcczfK5co6shcoauhBQtYSuX5NMa5nvuLV2THKnusjZlhn9q45EWqyqpN.zAzD5R28rh12irneZaMWAFN9zsqaITEzaJw05hppC.cL1ktwgMVU6VW+4OeWQXJnenjZZhb+FqhFWCoG1Dp7E8hIKC33ocVLoI7kpLa9KGMkFTsKbKGVUxdA8cFiqUkD8S26MBbHU1de8qIbYOLbRJe8BEn0P9eMteCaP0QW1Jnabsp9oIzktWDM6tzcuH1Ml3Rvmu80gn2fpKAaP0gUsWPeRRMAQj6f1uDolIoMad.ecfmUtmHEnIzktmAMqtzM525fs83ZMhlflwCVmtXCpNJp0B5QOtVuY5Nw05owCue+U.10rNaJVz6R26f32ktMgqcZWItVip4Q76khtRCpNNpkB5KfTyND0ldZ4.udZmM8T+rPdzKbeHf2GvVlw40zI5co6UAreU1d+3YOHt+p7qlTuSnXXQD6FT061goWkVPeJRM2v8Q9eiP+FqgtYbsddT7wj6B3kALqrM6J1bH8EuVN4+8N8a7KHtegnyk7e7YCGFWqw1AhMnZSTkUPO5w05kS2LtV2eFru880AbPYZNNShZW5dxU4N8XZ6HFeQndIDlMaZ70DZPUiQ1GoRufdSItVmXL2OahljzoFdXNd84A1wbLYG.6MouXVteO05HEYrQuYtNAx6wnKAiq0ln4CbVXCp1DTZEzMtViuikQ6X2CPpI5h3wtnzktMgaul4BbKT+GaLtVaGhdCpZLxVBEzaBw05mCiq0MG3mx3cr71AdADyytQN6R2KqF1+JKOapuiK2Cotq2FXpc4vI9MnZWMFYGqB5GBFWqMEuaJuiq+a.6S8N8GXKhzWfqt5R20PyqWL9pTsGSLtVa+hdCp1KFYWPUc.HnFoB5FWqMKOAfGjxuP1Gk3dGBbf.WKU+609n00NTI5IArJpliGWFFWqcIQsAU6M5ZwH6PUPeKH07AQs4HdHRMugcP6izER0cLe4jZ1p4Va6MCtIAdoTcco6xIteglYx4P4drXIXbs1kEoFTseiaE3Hqr893XfJnabs1b86P8b7+lIcs0hndco6CQ4tOeh04NQIaqA94L9GCLtVUOQoAUmtw2h1cLxNiEz2eF9a0o5bD4BI41r.tdp2WO9xD2uX0hIM+Ji8yagXdVIFFuJF88+0RJQwLtV0FqoDiraSUc.HiJrftw0Zy2qf77ZSzuzGkQW59rq8Yc4a1.2.C+990fw0plY0cCpNrikAb7ztpg7nJnuUXbs1FrU.+Lx6qU2IoqgcDaNw4R5Z+OJco6WMCy2pxAyfueuTrYS0vqtZP0QczlhQ1GQA8+LLtVaKNax+qW8FWKw81Gb6H0o5CZW5tJfmbVloUmuHS+97JI8nrMpmwEEeUcCpVFiKhleLxNEjtN4WA4+.ZQitbbsNJ1UJ+F.abGQOfe1GR2e8yz9weStlfUnclhuyULtVUYppZP0xZzziQ1ofp6dRcbGFWqilWAFAuihIHkDd2N8ete2j5N71nyjG495MQ5QVqTUH5wH6cP5N6po8iHmBhWSKD8eMWSvdP5VzH2uVVzHxm0k4QJ65e.djy4WUFmSUs4S5Zjabsp5TziQ1n93PtHgqfdjudqMQGIoPUH2utVzHx8EwNR5oM25H0M3yNuSmJ2Ahw0ppeyk3FirVPeDGQtina5lhzypauyEFMGDc2G1CR0kgsAUsf9iV1KnG86Y41jE.7oIFeAt9MLaAjz9PbhQVKnODCiq07X+H9o+mMjkT2UuFTM2wHqEzGfgw0Z9MIvwRpaNycA7hF9E9j5150fp4JFYsf9zL5cJUa5YfcaRzeB5YnlHobEirVPuOin+ryVovE4hH+EvKZ3y3dIcPTuwHqEz2nwkSpIGTyvgPJaiycA7hF9fAQpaqNiQVKnu9wsQpoFhXvgno2bH8THZYj+B38a3itSIskT8wHqEzA9fDyn8TCmsgzyM3nGirSUUG.jT3sXfuLVPGpnB5dsxaW1ShcLxtDfitp14kTivQfEzsftFXGEwNFYuLhaLxJop0rwB5VPWCko.NEhaLxtZfOBlI4RcMVP2B5ZDs.fOCwMFY8oFlT2hEzsftFS6OvUS9KfWz3l.NzJauWRQgEzsftJASB7hI87zN2EvKZbI.6RUc.PRYmEzsftJQaAvYRriQ1yDiQVo1HKnaAcUA1YfKl7W.unwRANNLFYkZSrftEzUE5PIcMrycA7hFWMFirRsEVP2B5phMGfWKotNO2Ev623yVc65RpFYAcKnqZx1R59CORwH68S5wxnjZ9rftEzUMau.tTxew70AbZU5dpjpSVP2B5JSNZRYvdtJle63CPHo1DKnaAckQSA71Hcpuq6B5+Q0v9mjpOVP2B5J.VHv4Q8EireafIpk8LIUWrftEzUfb.T8wH6Z.dJ00NjjpMVP2B5JXljTnuTUwH6mn91UjTMxB5vTSPpfdYdJH2df6pD2dp6Y9jdLs9pAlaIsM+E.KF3NJos2vZ9.6aIt8d.fqrD2dRMYyFXUk71bq.VdIuMqRVPWg1t.79.dVkv15s.7tKgsynZ+AthRb68C.10Rb6I0j0TKn+bHcVIKCyB7Ttq36vX7hQ1eDvlV6y5Go8mxcc1MWuSeoPqodJ2OgxbN6CnB0D7U.1CfWOi12X9M.7fk5LRRJXhdA8iBXEk33KTuSeUhVEvYS5zvetj5X8Aw2B3BqpIkjTTL6bOAlAygzyY6xxlUhaKkG+LfWNvGF38CbPSy+tqgzCGFIoVun+KzkJx0A7zAd9jhx094iA78qsYjjTFYAc0zc9j516SizsxUOKmzs9ljTmfEzUavuD3uDX2.9bj53y2NoSOujTmPzuF5RCiaG3EBbNjhQVIoNCKnq1nuStm.RR0MOk6RRRs.VPWRRpEvB5RRRs.VPWRRpEvB5RRRs.VPWihGComRPdWRHIED9AxZXLAveLvoCrCjdfobNYcFIII.+E5Zv8T.91.eJREygTbq9Xy0DRRROLKnqYxiG3S.bk.OsM5+ushTDqJIoLyB5pHaBvaD3G.bLT76UdY.6dMMmjjTArft5m+.fafz0Jeymg+cmMvYW4yHIIMsrft1POIfuFvWDXmFh+6dl.GQkLijjz.wB5BRWK7+ZfqG3fGwsw6kzooWRRYfEz61lEvqD3V.dMLd2Fi6DvwWFSJIIM7rfd20y.3ZA9f.aSIsMeq.OtRZaIIogfEz6d9UAt.fuIvdTxa6s.3cUxaSIIM.rfd2wlA7N.tIfmWE924X.12Jb6KIo9vB5se8hq0aF3jA1zJ9u2j.u+0+2URR0DKn2t8a.bE.eZfETi+cO.fitF+6II04YA81oGGvGG36BreYZNbF.Sko+1RRcNVPucYt.uARw05wRde8cQqetHIoZfEzaOd1jhq0yfT2lGAmD06o5WRpyxB5Me6Fv+BvEAryYdtrw1Lf2btmDRRcAVPu4ZqH0M4WOvgj44R+7f.uaROw1jjTEabh5SkGyB3kP5dJeay7boHeAfSD3Gm6IhjTWgEzaVd5jdHprm4dhTfa.30B7Mx8DQRpqwS4dyvNBb9.WJwrX9cC7p.1arXtjTV3uPO11LRWC5SjXdOcuZfOBvaCXYYdtHI0oYA8XZBfW.v6AXgYdtTjuAoSu9Mj6IhjjrfdDsujtN46etmHE3GS5LF7Ex8DQRROLuF5ww1C7w.9dDyh42GvaA3IiEykjBG+E542bAdM.mBwIg21PqizC2k2DvOMyyEIIU.KnmWOKf2Gvtj6IRA9tjtN4WYtmHRRZ54obOO1UfuBvkPLKleG.GCvSCKlKI0HXA850VR5Wj+8ANzLOW5mUBb5.KF3umzoaWRRM.dJ2qGyB33.dmD23Z8KBbB.+nbOQjjzvyB5UuChzsg1dk6IRA9uHccx+54dhHIoQmmx8pyNB74AtLhYw7kQp652KrXtjTim+B8x27.No0OhXbstFd33Z8ty7bQRRkDKnWtdr.WKvhx8Do.eSRmd8+ybOQjjT4xS4d45tAttbOI5iaE34A76hEykjZkrfd46DHc6eEA2GvIC7j.tvLOWjjTExB5kueDotZOm5EWq6Jv6B3Ay6zQRRUMKnWMdW.KMS+suJRObWdQ.+jLMGjjTMyB5Ui6E3sVy+MWJvwB7TA9N07eaIIkYVPu57IAtlZ3uyJANCRYB+mDXs0veSIIELVPu5rVR2hXUYdneQ.6NvaD3WTg+cjjTvYA8p0U.b9Uv18FANDfi.3GVAaeII0vXA8p2IA7KKos08.b7.6IvWqj1lRRpEvB5UuaG3LGyswZ.9vjtN4mCvpG2IkjjZWrfd838.7+Nh+2do.6CvqD3mWVSHII0tXA85wCPpw0FFKA3n.dF.e+xdBIIo1EKnWe9r.+6Cv+d2Ovo.ra.WPkNijjTqgEzqOqizswVQ2m3qC3yPJtVemXbsJIogfEzqWWEvmpO+yuZfC.3OgQ+ZsKIoNLKnW+dyjdJnAo3Z83.9sXvNc7RRR80ry8DnC5N.NMfsmzoV+dy5rQRRsBVPOONqbOAjjT6hmxcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.SJNo5wcC7OUhaueZItsjTKfEzkpG2LvQl6IgjBkkB7cKos0jSP54y8DkzFDROzQtqRZasi.O0RZaAoCdWVIt8jjT9MafUUxaysBX4k71rJMUz+E5215GRRRZZXSwIII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BTEEzec.yoB1tRRR8SzetjTaVKv5J4wMAbX04Ngjj5jNXfe.kecrsrN2IJASAUSA8diKAXWpq8FII0YrS.+yTc0urfdeFqD38BL+5YeRRRsXaNvoC7fTs0trf9zLVJvwgMhmjjFdSBbL.+TpmZVVPe.FWCvATC6bRRpc3oA7codqUYA8AbrVfyCXgU9tnjjZp1AfOE4oNkEzGxw8C715MQjjj.1Tf2Bvuf7UexB5i3XI.GcktqJMXdt.+Z4dRjYaMviK2SB0Y8bA9wj+5RVPeLGWFvdUk6wRE3WG3aP58gWPlmK41GBXE.mDvby7bQcGa3ZvHLrfdILVMvGAXaqt8ao+eOVfO.o22sguO72NiyobZO3Qdr3V.d1YcFo1thVCl6Qirf9ZH+G3523dvXjUUmYC7pAta5+6+9O.lU1lc4SQ+BouJvtkw4kZelo0f4dzHKneH.WG4+fWQiaB3PqnC.pa5fAtAl4268xy0DLSdNL8GOdHf2OvVkqInZMdlLXqAy035H0XdMISAoDbaq.dU.2I4+.YQCiQVMtdhLbQE4cQy6aoOp1DfeDC1wkeFvqft4YvPimgcMXcOtKReQ9l36s++Kn2ar8.mIo3ZM2GX62Xkqe9sEUvAC0dMNQE4Ykg4aN7lX3O17eP2sWCzvYyAd2T8w05nNdHfyll8Wf+QUPu2oXXWH8Khy8A4hFFirZPLIveFiWTQtRfEW2S7Z1iG3dYzOF8OB7qV2SZ0HLAi+Zvpd7uP6n+PJrfdOGJoqgctOfWz3pA1+R5fgZWdpTdQE4kTyy851Gmw+XzC.7N.1rZdtq3pLWCVEiaA32ux16qeyXAcH0k4uNRccdteAneCiQVsg1Af+AJ+aGyCoN2IpQ+FTt2oK+O.+Qj9kYpa5WgpYMXYMVAvaf1WFKLPEz6YaIc+gGs6UvdCiQ1tspNpHuQZe2BkS.bETMGu91j9xBp6HBw05zMVCveGodEqMZnJn2ydQJQ2x8KNEMVBvQM7GKTCVcEUjul5ZGpl7Bod9.TiQ11umCC9cIQNFWAs+uf4HUPumilTwyb+BUQiKEiQ11t5NpHWFoTspMXd.2F0yws15o3TwKtV23QW5R.MVEz6sANURmt6b+BW+FqF3CiwHaaSunhbUT+um5CTC6e0gSk5+XmwHa6QNWCNHiG.3sS2pIMG6B58rPfOKwsIHtGfWKsuqAZWyrIE.R4LpHWEvtW06nUrERd+R3skaSntnHrFblFc0aixRqfdOG.v0P9eAsnwMR6saka6hTTQ9uVw6qUsyi7eLzXjs4IRqA62nqGzQkdAcHElGuDhcLxdw.6bIrupp2SD3KP9eOyFONhpbmtBseDqyjVSNpM6Jh5ZvdCih3jJofdOyG38RriQ1y.iQ1nJ5QE4MQyqQalD3pH+G652nq+qqhnnuFzyxyiTkVPumlPLx9hwXjMJLpHqNyh3e8OOe5lW+yHw0fMS0RA8dNLhcLxdUXLxlaMgnhrMzk11gxpHOUfqj7+df19ZvpPsVPGZFwH6mAXAU0A.0WFUj4g2CwpGWC17U6Ez6Y6.NWJ2LjtLG2GvofwHaUqoDUjs8jNqtRZuQcbE.6aks22sso.uYh8ZvONs+0fkgrUPum8lXGir2JvQVY68caQOpH6ZYQdS4KW0Vyg6bv0fsKYufNjNcZOepuXnbTFeKf8rpN.zw7qC70I+ulVznqeZdqpmVck0XE.mHdpWGG6NweM3eLc20fipPTPum4Q7iQ1ODv1TUG.Z4dr.+sD6Fwxmm2OrlPCJ1ldVVWGbMX6VnJn2yhH1wH6x.NdLFYGTFUjMWSR7u8k9J3suzLw0fcCgrfdOGHFirMcOSf+Sx+qUEMLLSFLaNvoSrCXjyFXKqpC.MX+t3ZvthPWPGZFwH6EgwH6Fynhrc5IB7OS9e8qngwH6C6IfqA6ZBeA8dlOvYQ5ahm62H1ugwHaxiAiJxtfClX+P535.d5U1der8X.9qv0fcQMlB58rXfuD4+MkEMtCfiktWLxNAveJvOg7+ZPQiuJvSppN.zAMafWMw95xd9.6XUc.HXbMnZbEz64vAtYx+aPKZbUjdpV0E7agQEYWVuXjc0j+Wq623A.9KIcWzzVE80f+23Zv5PisfNj5x7WOvxI+ugsei0B7oo8Fir+J.+8D26FgU.bR38qbcI5wH6sC7BoccuM6ZPsgZzEz6Y6.9nD6Xj8jo8DiraBFUjpXFirUOWCp9oUTPum8A3xI+uYtnwsRyOFYMpH0fXSAdqD6BNeLZlwH6eHweM3Sox160zoUUPGLFYqJFUjZTrC.eJh8oDtoDirtFTyjVWA8dlGvogwH63ZqI1QE4uDiJxlfmFv2i7+9khF+.haLxt0.+M3ZPMyZsEz6YQ.eNh6uPXY.uFR2BPQxrA9KH12RRFUjMKSBbLD+XjcWqn8+gUu0f+bx+wkhFW.tFLRZ8Ez64.AtVx+BfhF+W.+dU1d+vI5QE40iQEYSlwH6LqIrF7YTY68ZT0YJnCoegvKkXGireQfcppN.LCdB.W3.LGy0vnhrcYmH898b+9phF2EvKi588aMg0fuRbMXT0oJn2yVB79HtwH6CB7dn9hQ1nGUjqB3uFiJx1pClzYnJ2uOqnw0AbPU1deRu0f+xLuu5ZvlsNYA8dVLvWl7uXonQUGirFUjJJlModIYYj+2yUz3yS4GirtFTkoNcA8dNbRc4ZtW3Tz36QpKgKSMgnh7Onj2mU7sM.eP5FwHqqAUYyB5q2bANAheLxtCi49YziJx6kTTQtIi49oZ11CfuI4+8iEMFmXj8wC7Iw0fp7YA8MRSHFYeqL7uNYTQplnmGwNFY+2XviQ1MA3MQpfYtm2EsF7SfqAaxrfdA1GRKVy8hrhF+XReX2f3OD3GFf4bQi+cLpHUw5Eir2G4+8pEUHblhQVWCp5fEzmFS.7BHc50x8BthFeSRmdx9Y2A9WCvbrnw+KFUjZvE8Xjc4jtrcaXLx1DVC9mfqAaKrf9.nWLx9.j+Ef8arZRMRTuXjsIDUjuSLpH0noIDiruHbMnpeVPeHrijt0Ux8hwhFqfzGlrh.LWJZbA.+ZC6AdoMRuXj8NH+umtoMbMX6kEzGAGDovlH2KLaRCiJRUE1bRgvTTCEoHMbMX6mEzGQyhTrPdWj+EpQdXTQp5PziQVWCp5fEzGSQOFYy0vnhT4vuGwNFYq60fmCtFrKwB5kjckzidwbuHNBiuFFUjJeZBwHqqAUUvB5krmEwNFYqxgQEohjnGirtFTkMKnWAlKvIRbiQ1xdbu.uQLpHULE8Xj00fprXA8Jz1SJAohZLxNtidQE4iurNfIUgdd.2J4eciqAUUwB50f8kXGirixvnhTMQaJvISbiQVWCpwgEzqISP5oyTjiQ1AYXTQp1fEP5oWXTiQVWCpQgEzqYyizyS4nFirEM5EUjOlx+PhT1reD6Xj00fZXXA8LYGANex+GRLHCiJR0lMIvwRriQ1+IbMnlYVPOyd5D2Xj0nhTcIaAoXjckj+0d8FeefempbmVsJVPO.lEvKm3Dir+bLpHU20NAbQj+0f+43ZPMbrfdfrk.mM4KFY6EUjacUuiJ0.jiXj00fZbXA8.Z2n9iQ1uFvStN14jZPlCvwS8DirtFTiKKnGX+9.2BU6Gh7CANh5ZGRpgZa.9PTMwHqqAUYwB5AWuXjcETteHhQEozvaOA9V3ZPESVPugX6A96X7iQViJRow2QxnGirqA3ShqAU4yB5ML6KvUvn8AIeGfey5eJK0JMECeLx5ZPUkl5+CcDZj5LFOo9I.....IUjSD4pPfIH" ],
									"embed" : 1,
									"forceaspect" : 1,
									"id" : "obj-76",
									"maxclass" : "fpic",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "jit_matrix" ],
									"patching_rect" : [ 24.166660308837891, 19.999998092651367, 102.133331298828125, 53.92639892578125 ],
									"pic" : "acids.png"
								}

							}
, 							{
								"box" : 								{
									"fontface" : 1,
									"fontsize" : 14.0,
									"id" : "obj-17",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 34.199996948242188, 125.79998779296875, 109.0, 22.0 ],
									"text" : "dimension #1",
									"textcolor" : [ 0.996078431606293, 0.996078431606293, 0.996078431606293, 1.0 ]
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-15",
									"maxclass" : "ezdac~",
									"numinlets" : 2,
									"numoutlets" : 0,
									"patching_rect" : [ 172.133346557617188, 666.2000732421875, 45.0, 45.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-14",
									"maxclass" : "gain~",
									"multichannelvariant" : 0,
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "signal", "" ],
									"parameter_enable" : 1,
									"patching_rect" : [ 20.133346557617188, 577.00006103515625, 235.0, 20.0 ],
									"saved_attribute_attributes" : 									{
										"valueof" : 										{
											"parameter_longname" : "gain~[3]",
											"parameter_mmax" : 157.0,
											"parameter_shortname" : "gain~[3]",
											"parameter_type" : 0
										}

									}
,
									"varname" : "gain~"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-13",
									"maxclass" : "newobj",
									"numinlets" : 8,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 20.133346557617188, 535.60003662109375, 235.5, 22.0 ],
									"text" : "nn~ additive decode 2048"
								}

							}
, 							{
								"box" : 								{
									"angle" : 270.0,
									"bgcolor" : [ 0.2, 0.2, 0.2, 1.0 ],
									"id" : "obj-25",
									"maxclass" : "panel",
									"mode" : 0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 22.533340454101562, 120.79998779296875, 170.000015258789062, 185.0 ],
									"proportion" : 0.5
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-13", 0 ],
									"source" : [ "obj-1", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-14", 0 ],
									"source" : [ "obj-13", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-15", 1 ],
									"hidden" : 1,
									"order" : 0,
									"source" : [ "obj-14", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-15", 0 ],
									"hidden" : 1,
									"order" : 1,
									"source" : [ "obj-14", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-1", 0 ],
									"hidden" : 1,
									"midpoints" : [ 32.033340454101562, 113.0, 32.033340454101562, 113.0 ],
									"order" : 3,
									"source" : [ "obj-21", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-10", 0 ],
									"hidden" : 1,
									"midpoints" : [ 32.033340454101562, 113.0, 574.0, 113.0, 574.0, 149.0, 583.5333251953125, 149.0 ],
									"order" : 2,
									"source" : [ "obj-21", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-5", 0 ],
									"hidden" : 1,
									"midpoints" : [ 32.033340454101562, 113.0, 205.0, 113.0, 205.0, 149.0, 217.633331298828125, 149.0 ],
									"order" : 1,
									"source" : [ "obj-21", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-9", 0 ],
									"hidden" : 1,
									"midpoints" : [ 32.033340454101562, 113.0, 391.0, 113.0, 391.0, 149.0, 401.933349609375, 149.0 ],
									"order" : 0,
									"source" : [ "obj-21", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-12", 0 ],
									"hidden" : 1,
									"midpoints" : [ 948.70001220703125, 357.0, 906.0, 357.0, 906.0, 150.0, 204.0, 150.0, 204.0, 159.0, 159.0, 159.0, 159.0, 390.0, 29.633346557617188, 390.0 ],
									"order" : 3,
									"source" : [ "obj-22", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-18", 0 ],
									"hidden" : 1,
									"midpoints" : [ 948.70001220703125, 357.0, 357.0, 357.0, 357.0, 393.0, 217.633331298828125, 393.0 ],
									"order" : 2,
									"source" : [ "obj-22", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-19", 0 ],
									"hidden" : 1,
									"midpoints" : [ 948.70001220703125, 357.0, 540.0, 357.0, 540.0, 393.0, 401.933349609375, 393.0 ],
									"order" : 1,
									"source" : [ "obj-22", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-20", 0 ],
									"hidden" : 1,
									"midpoints" : [ 948.70001220703125, 357.0, 726.0, 357.0, 726.0, 393.0, 580.033248901367188, 393.0 ],
									"order" : 0,
									"source" : [ "obj-22", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-46", 0 ],
									"source" : [ "obj-45", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-13", 0 ],
									"midpoints" : [ 790.5, 522.0, 29.633346557617188, 522.0 ],
									"order" : 2,
									"source" : [ "obj-46", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-23", 0 ],
									"midpoints" : [ 790.5, 522.0, 301.633346557617188, 522.0 ],
									"order" : 1,
									"source" : [ "obj-46", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-24", 0 ],
									"midpoints" : [ 790.5, 522.0, 508.633346557617188, 522.0 ],
									"order" : 0,
									"source" : [ "obj-46", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-8", 0 ],
									"hidden" : 1,
									"source" : [ "obj-6", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-73", 0 ],
									"hidden" : 1,
									"source" : [ "obj-71", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-14", 0 ],
									"hidden" : 1,
									"source" : [ "obj-73", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-75", 0 ],
									"hidden" : 1,
									"source" : [ "obj-74", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-21", 0 ],
									"hidden" : 1,
									"order" : 2,
									"source" : [ "obj-75", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-22", 0 ],
									"hidden" : 1,
									"order" : 1,
									"source" : [ "obj-75", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-6", 0 ],
									"hidden" : 1,
									"order" : 0,
									"source" : [ "obj-75", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-71", 0 ],
									"hidden" : 1,
									"source" : [ "obj-75", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-14", 0 ],
									"hidden" : 1,
									"source" : [ "obj-8", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 367.0, 99.0, 69.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"tags" : ""
					}
,
					"text" : "p moudular"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-10",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 8,
							"minor" : 5,
							"revision" : 0,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"classnamespace" : "box",
						"rect" : [ 202.0, 155.0, 1306.0, 721.0 ],
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
						"showontab" : 1,
						"assistshowspatchername" : 0,
						"boxes" : [ 							{
								"box" : 								{
									"basictuning" : 440,
									"data" : 									{
										"clips" : [ 											{
												"absolutepath" : "Macintosh HD:/Users/domkirke/Dropbox/code/vschaos2/patches/Chrompahone.Verse2.aif",
												"filename" : "Chrompahone.Verse2.aif",
												"filekind" : "audiofile",
												"id" : "u236001100",
												"loop" : 0,
												"content_state" : 												{

												}

											}
 ]
									}
,
									"followglobaltempo" : 0,
									"formantcorrection" : 0,
									"id" : "obj-4",
									"maxclass" : "playlist~",
									"mode" : "basic",
									"numinlets" : 1,
									"numoutlets" : 5,
									"originallength" : [ 0.0, "ticks" ],
									"originaltempo" : 120.0,
									"outlettype" : [ "signal", "signal", "signal", "", "dictionary" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 502.0, 180.0, 150.0, 30.0 ],
									"pitchcorrection" : 0,
									"quality" : "basic",
									"timestretch" : [ 0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-50",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 256.533313751220703, 277.5, 93.0, 22.0 ],
									"text" : "get temperature"
								}

							}
, 							{
								"box" : 								{
									"format" : 6,
									"id" : "obj-44",
									"maxclass" : "flonum",
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "", "bang" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 357.166660308837891, 248.5, 50.0, 22.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-42",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 357.166660308837891, 277.5, 109.0, 22.0 ],
									"text" : "set temperature $1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-16",
									"linecount" : 3,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 265.0, 199.5, 224.199996948242188, 47.0 ],
									"text" : "As VAEs have probabilistic encoders, temperature drives the encoding randomness (default : 0)"
								}

							}
, 							{
								"box" : 								{
									"fontface" : 1,
									"fontsize" : 20.0,
									"id" : "obj-41",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 265.0, 171.79998779296875, 189.0, 29.0 ],
									"text" : "Temperature"
								}

							}
, 							{
								"box" : 								{
									"fontsize" : 16.0,
									"id" : "obj-39",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 929.50006103515625, 312.0, 339.0, 24.0 ],
									"text" : "(one latent trajectory / spectral chunk)"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-38",
									"maxclass" : "scope~",
									"numinlets" : 2,
									"numoutlets" : 0,
									"patching_rect" : [ 934.0, 385.00006103515625, 130.0, 130.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-37",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "multichannelsignal" ],
									"patching_rect" : [ 934.0, 347.0, 187.0, 22.0 ],
									"text" : "mcs.nn~ ordinario encode 1 4096"
								}

							}
, 							{
								"box" : 								{
									"fontsize" : 12.095714101180841,
									"id" : "obj-48",
									"linecount" : 3,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 25.166660308837891, 180.0, 215.0, 47.0 ],
									"text" : "when the mode is forward, phase inversion can also buffer the incoming phase to use it during reconstruction. "
								}

							}
, 							{
								"box" : 								{
									"fontface" : 1,
									"fontsize" : 20.0,
									"id" : "obj-49",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 140.0, 77.918949127197266, 189.0, 29.0 ],
									"text" : "Inversion mode"
								}

							}
, 							{
								"box" : 								{
									"basictuning" : 440,
									"data" : 									{
										"clips" : [ 											{
												"absolutepath" : "talk.aiff",
												"filename" : "talk.aiff",
												"filekind" : "audiofile",
												"id" : "u305004739",
												"loop" : 0,
												"content_state" : 												{

												}

											}
 ]
									}
,
									"followglobaltempo" : 0,
									"formantcorrection" : 0,
									"id" : "obj-36",
									"maxclass" : "playlist~",
									"mode" : "basic",
									"numinlets" : 1,
									"numoutlets" : 5,
									"originallength" : [ 0.0, "ticks" ],
									"originaltempo" : 120.0,
									"outlettype" : [ "signal", "signal", "signal", "", "dictionary" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 808.0, 180.0, 150.0, 30.0 ],
									"pitchcorrection" : 0,
									"quality" : "basic",
									"timestretch" : [ 0 ]
								}

							}
, 							{
								"box" : 								{
									"basictuning" : 440,
									"data" : 									{
										"clips" : [ 											{
												"absolutepath" : "vibes-a1.aif",
												"filename" : "vibes-a1.aif",
												"filekind" : "audiofile",
												"id" : "u339011385",
												"loop" : 0,
												"content_state" : 												{

												}

											}
 ]
									}
,
									"followglobaltempo" : 0,
									"formantcorrection" : 0,
									"id" : "obj-34",
									"maxclass" : "playlist~",
									"mode" : "basic",
									"numinlets" : 1,
									"numoutlets" : 5,
									"originallength" : [ 0.0, "ticks" ],
									"originaltempo" : 120.0,
									"outlettype" : [ "signal", "signal", "signal", "", "dictionary" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 656.0, 212.0, 150.0, 30.0 ],
									"pitchcorrection" : 0,
									"quality" : "basic",
									"timestretch" : [ 0 ]
								}

							}
, 							{
								"box" : 								{
									"basictuning" : 440,
									"data" : 									{
										"clips" : [ 											{
												"absolutepath" : "cello-f2.aif",
												"filename" : "cello-f2.aif",
												"filekind" : "audiofile",
												"id" : "u184003693",
												"loop" : 1,
												"content_state" : 												{
													"loop" : 1
												}

											}
 ]
									}
,
									"followglobaltempo" : 0,
									"formantcorrection" : 0,
									"id" : "obj-28",
									"maxclass" : "playlist~",
									"mode" : "basic",
									"numinlets" : 1,
									"numoutlets" : 5,
									"originallength" : [ 0.0, "ticks" ],
									"originaltempo" : 120.0,
									"outlettype" : [ "signal", "signal", "signal", "", "dictionary" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 656.0, 180.0, 150.0, 30.0 ],
									"pitchcorrection" : 0,
									"quality" : "basic",
									"timestretch" : [ 0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-45",
									"items" : [ "keep_input", ",", "random", ",", "sinebank", ",", "pghi" ],
									"maxclass" : "umenu",
									"numinlets" : 1,
									"numoutlets" : 3,
									"outlettype" : [ "int", "", "" ],
									"parameter_enable" : 0,
									"patching_rect" : [ 25.166660308837891, 237.5, 100.0, 22.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-46",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 25.166660308837891, 272.5, 129.0, 22.0 ],
									"text" : "set inversion_mode $1"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-9",
									"maxclass" : "ezdac~",
									"numinlets" : 2,
									"numoutlets" : 0,
									"patching_rect" : [ 656.133346557617188, 434.2000732421875, 45.0, 45.0 ]
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-10",
									"maxclass" : "gain~",
									"multichannelvariant" : 0,
									"numinlets" : 1,
									"numoutlets" : 2,
									"outlettype" : [ "signal", "" ],
									"parameter_enable" : 1,
									"patching_rect" : [ 656.133346557617188, 383.00006103515625, 235.0, 20.0 ],
									"saved_attribute_attributes" : 									{
										"valueof" : 										{
											"parameter_longname" : "gain~[5]",
											"parameter_mmax" : 157.0,
											"parameter_shortname" : "gain~[3]",
											"parameter_type" : 0
										}

									}
,
									"varname" : "gain~"
								}

							}
, 							{
								"box" : 								{
									"id" : "obj-8",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "signal" ],
									"patching_rect" : [ 656.0, 347.0, 152.0, 22.0 ],
									"text" : "nn~ ordinario forward 4096"
								}

							}
, 							{
								"box" : 								{
									"autofit" : 1,
									"forceaspect" : 1,
									"id" : "obj-7",
									"maxclass" : "fpic",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "jit_matrix" ],
									"patching_rect" : [ 145.633346557617188, 30.039263517206365, 130.0, 37.936363636363637 ],
									"pic" : "/Users/domkirke/Dropbox/code/vschaos2/assets/logo.png"
								}

							}
, 							{
								"box" : 								{
									"fontsize" : 16.0,
									"id" : "obj-2",
									"linecount" : 2,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 311.933349609375, 70.918949127197266, 665.0, 42.0 ],
									"text" : "vschaos can also be used to perform timbre transfer, encoding audio in the latent representation."
								}

							}
, 							{
								"box" : 								{
									"fontface" : 1,
									"fontsize" : 30.0,
									"id" : "obj-3",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 311.933349609375, 29.007445335388184, 665.0, 40.0 ],
									"text" : "timbre transfer"
								}

							}
, 							{
								"box" : 								{
									"autofit" : 1,
									"data" : [ 8126, "png", "IBkSG0fBZn....PCIgDQRA..APO..D.BHX....PpFZ.5....DLmPIQEBHf.B7g.YHB..eTWRDEDU3wY6cuG+kTWWGG+0ue6E32hvBHWzX2kRAVPItlkxMyRhKlQp.pUVf30REUP7FHjWRDDwn7FZpkJpDgIfZZdAHLQ4VXDfjJKTJKnrrKBHK6s9iu6IVVNyuemKyLe+Ly754iGe+CQX98cly464y4Lym48LAv7QsA6AvoCreav+reBvaC3BAVWNlTRsbSB7h.dh.uWf6MuSG0kMAVPuoaa.NYRenxrJ3emqD3MBb800jRpCX+H8kn2i0++9mA7N.9z.qMWSJ0cYA8lq4.7RIUndPdMbsj9fl2AoO3QRilE.71AdtE7++0C7l.9N01LRhGcA8UCrpLMWzf6P.NSfEOB+2tBf+JfO.9ZszvXJfSD30CLuY3e20A7OB7V.9ep34kDj9QdL+MXroYc5nYxt.bIj9vhwcby.Gd8N8kZjl.3E.baL7qytefSkY9K.HMtlBrfdSv7I0vMqjxoX9FN9xLZ+Reotf8A3xY7Wmca.O+ZdtqtEKnGbSB7R.VJkeg7Mb7P.mE1OER8rc.eTf0P4tV6x.16Zb+PcGVPOvN.fqgpsP9FOtSRMZ2j0v9mTDMWRWi7kS0sNa0.mKouzfTYwB5AzBA9rj5J85rX9FNtVfCrp2QkBlCmTukTWqytGfWGquYljFSVPOPlhTHvb+juB4a3Xs.eNfEUk6zRAvhI0KI4Zs1MAbXU9doZ6rfdPbz.Kg7WDueC6RW0VMeR8NxCQ9WmsNR2AK6RktGq1LKnmY6EoljI2ePxfL50ktSTIGIjpOSRpWQtSx+5pMdrRR2QK1fpZXYA8LYaA9HjZNlb+AHC63xwtzUMWGHodDI2qilowcR5NbwFTUCJKnWylColf4dH+efw3LVC1ktpYYQj5Ijb1roix3ZHcGuHMSrfdM5PI07K49CHJywxIcK9XW5pnZd.mFwoYSGkwZIcmurvx8PiZYrfdMnLiq0nNtYrKcUrLAod9XThq0nN50fpSUhGmT6gEzqPUYbsF0wWBiQVke6MkSbsF0wRHcmwHsgrfdEXRfiipOtVi5vtzU4x1Qp2NJ63ZMpCiQVsgrfdI6..tZx+B8HLrKcUcYNT8w0ZTGqlzcLy1N1GEUSmEzKIKD37n40As0wvtzUUo5NtVi5vXjUVPeLEs3ZMpC6RWU1VLod1H2u2NZCiQ1tKKnOFhbbsF0gcoqFWQKtVi5vXjs6wB5ifnGWqKA3cAboAXtLcyQ6RWMLljTOYDw3ZMpCaP0tEKnODhdbsd+jN8+a3u98n.t0.L2JZXW5pAwARpWLx86WKZrZfUEf4QQikR5NuwFTscyB5CfnGWqyz0mdJfSA39BvbsnOLztzU8yhH8d6n1ro2CvqkGtQzhdZPd0XCp1lYA8YPzWfNLcP9B.9LD6ObztzUPJtVOUhayltZfOL8+Kg1D9A.mG1fpsQVPu.QOtVWJi98389SruW4sKc6tZBw05kBrmCv9RS7RzolMKnuQlOvYRbiq0xpIWlD3ESrSyN6R2tknGWq2JodRYX0DZhVaP01AKnudMg3ZsJJvsEzM9BLJthdbsdej5Akw8WxF8ay0KizW9PMWVPm3GWq0wofdmAt3.ruVzvtzs8I5w05ZI0yIKnD2midPTYCp1r0oKnG83ZMGMIVzaBP6R21gCiXGWqWModMop3m8npPmrfteK4o2bHcq3XW5pxVziq0kRp2RpqyDzAPru+5uIReIe0Lz4JneTD+qiUTBZE6RWUVlOodgHx8pwYRpmRpac092QkuNSA88BiB0QkG6znpIDWqWLodHI27K8nwUqufdS3WYdpzL9UlQ+raboXW5FIQOtVuQh4oStIjAF1fpwTqsfdS35.2DebhZ+GnYRSKtVipCi32fpUYiCpgWqrfdz6T6gItViplPW51D9P61jon4FWqQkwHqFFspB56Bw9do9NYziq0npIbO7GwSqZaSSHtVaxWNllvkNzFTM+ZEEzMsyxqlPW5FkFepsYuI9wZ5nDWqQkGu0zoQWPuITHoKc6dXW51czKtV8WLlGQOFYuTZ1mQjlpFaAcehgEWMgtzsNCOj1Dultwg8rf1XMtB5MglwxHSLwtzscwWOioEh2UAJowTPuIb6RctjNUj5g0D9Eck8Cfi1llvYbw6K53GirQ899uMoQTPO5AZRjhq0nJ5coaY8HxrMwdhn4wj4qaKzEzidjidajtcczfK5co6shcoauhBQtYSuX5NMa5nvuLV2THKnusjZlhn9q45EWqyqpN.zAzD5R28rh12irneZaMWAFN9zsqaITEzaJw05hppC.cL1ktwgMVU6VW+4OeWQXJnenjZZhb+FqhFWCoG1Dp7E8hIKC33ocVLoI7kpLa9KGMkFTsKbKGVUxdA8cFiqUkD8S26MBbHU1de8qIbYOLbRJe8BEn0P9eMteCaP0QW1Jnabsp9oIzktWDM6tzcuH1Ml3Rvmu80gn2fpKAaP0gUsWPeRRMAQj6f1uDolIoMad.ecfmUtmHEnIzktmAMqtzM525fs83ZMhlflwCVmtXCpNJp0B5QOtVuY5Nw05owCue+U.10rNaJVz6R26f32ktMgqcZWItVip4Q76khtRCpNNpkB5KfTyND0ldZ4.udZmM8T+rPdzKbeHf2GvVlw40zI5co6UAreU1d+3YOHt+p7qlTuSnXXQD6FT061goWkVPeJRM2v8Q9eiP+FqgtYbsddT7wj6B3kALqrM6J1bH8EuVN4+8N8a7KHtegnyk7e7YCGFWqw1AhMnZSTkUPO5w05kS2LtV2eFru880AbPYZNNShZW5dxU4N8XZ6HFeQndIDlMaZ70DZPUiQ1GoRufdSItVmXL2OahljzoFdXNd84A1wbLYG.6MouXVteO05HEYrQuYtNAx6wnKAiq0ln4CbVXCp1DTZEzMtViuikQ6X2CPpI5h3wtnzktMgaul4BbKT+GaLtVaGhdCpZLxVBEzaBw05mCiq0MG3mx3cr71AdADyytQN6R2KqF1+JKOapuiK2Cotq2FXpc4vI9MnZWMFYGqB5GBFWqMEuaJuiq+a.6S8N8GXKhzWfqt5R20PyqWL9pTsGSLtVa+hdCp1KFYWPUc.HnFoB5FWqMKOAfGjxuP1Gk3dGBbf.WKU+609n00NTI5IArJpliGWFFWqcIQsAU6M5ZwH6PUPeKH07AQs4HdHRMugcP6izER0cLe4jZ1p4Va6MCtIAdoTcco6xIteglYx4P4drXIXbs1kEoFTseiaE3Hqr893XfJnabs1b86P8b7+lIcs0hndco6CQ4tOeh04NQIaqA94L9GCLtVUOQoAUmtw2h1cLxNiEz2eF9a0o5bD4BI41r.tdp2WO9xD2uX0hIM+Ji8yagXdVIFFuJF88+0RJQwLtV0FqoDiraSUc.HiJrftw0Zy2qf77ZSzuzGkQW59rq8Yc4a1.2.C+990fw0plY0cCpNrikAb7ztpg7nJnuUXbs1FrU.+Lx6qU2IoqgcDaNw4R5Z+OJco6WMCy2pxAyfueuTrYS0vqtZP0QczlhQ1GQA8+LLtVaKNax+qW8FWKw81Gb6H0o5CZW5tJfmbVloUmuHS+97JI8nrMpmwEEeUcCpVFiKhleLxNEjtN4WA4+.ZQitbbsNJ1UJ+F.abGQOfe1GR2e8yz9weStlfUnclhuyULtVUYppZP0xZzziQ1ofp6dRcbGFWqilWAFAuihIHkDd2N8ete2j5N71nyjG495MQ5QVqTUH5wH6cP5N6po8iHmBhWSKD8eMWSvdP5VzH2uVVzHxm0k4QJ65e.djy4WUFmSUs4S5Zjabsp5TziQ1n93PtHgqfdjudqMQGIoPUH2utVzHx8EwNR5oM25H0M3yNuSmJ2Ahw0ppeyk3FirVPeDGQtina5lhzypauyEFMGDc2G1CR0kgsAUsf9iV1KnG86Y41jE.7oIFeAt9MLaAjz9PbhQVKnODCiq07X+H9o+mMjkT2UuFTM2wHqEzGfgw0Z9MIvwRpaNycA7hF9E9j5150fp4JFYsf9zL5cJUa5YfcaRzeB5YnlHobEirVPuOin+ryVovE4hH+EvKZ3y3dIcPTuwHqEz2nwkSpIGTyvgPJaiycA7hF9fAQpaqNiQVKnu9wsQpoFhXvgno2bH8THZYj+B38a3itSIskT8wHqEzA9fDyn8TCmsgzyM3nGirSUUG.jT3sXfuLVPGpnB5dsxaW1ShcLxtDfitp14kTivQfEzsftFXGEwNFYuLhaLxJop0rwB5VPWCko.NEhaLxtZfOBlI4RcMVP2B5ZDs.fOCwMFY8oFlT2hEzsftFS6OvUS9KfWz3l.NzJauWRQgEzsftJASB7hI87zN2EvKZbI.6RUc.PRYmEzsftJQaAvYRriQ1yDiQVo1HKnaAcUA1YfKl7W.unwRANNLFYkZSrftEzUE5PIcMrycA7hFWMFirRsEVP2B5phMGfWKotNO2Ev623yVc65RpFYAcKnqZx1R59CORwH68S5wxnjZ9rftEzUMau.tTxew70AbZU5dpjpSVP2B5JSNZRYvdtJle63CPHo1DKnaAckQSA71Hcpuq6B5+Q0v9mjpOVP2B5J.VHv4Q8EireafIpk8LIUWrftEzUfb.T8wH6Z.dJ00NjjpMVP2B5JXljTnuTUwH6mn91UjTMxB5vTSPpfdYdJH2df6pD2dp6Y9jdLs9pAlaIsM+E.KF3NJos2vZ9.6aIt8d.fqrD2dRMYyFXUk71bq.VdIuMqRVPWg1t.79.dVkv15s.7tKgsynZ+AthRb68C.10Rb6I0j0TKn+bHcVIKCyB7Ttq36vX7hQ1eDvlV6y5Go8mxcc1MWuSeoPqodJ2OgxbN6CnB0D7U.1CfWOi12X9M.7fk5LRRJXhdA8iBXEk33KTuSeUhVEvYS5zvetj5X8Aw2B3BqpIkjTTL6bOAlAygzyY6xxlUhaKkG+LfWNvGF38CbPSy+tqgzCGFIoVun+KzkJx0A7zAd9jhx094iA78qsYjjTFYAc0zc9j516SizsxUOKmzs9ljTmfEzUavuD3uDX2.9bj53y2NoSOujTmPzuF5RCiaG3EBbNjhQVIoNCKnq1nuStm.RR0MOk6RRRs.VPWRRpEvB5RRRs.VPWRRpEvB5RRRs.VPWihGComRPdWRHIED9AxZXLAveLvoCrCjdfobNYcFIII.+E5Zv8T.91.eJREygTbq9Xy0DRRROLKnqYxiG3S.bk.OsM5+ushTDqJIoLyB5pHaBvaD3G.bLT76UdY.6dMMmjjTArft5m+.fafz0Jeymg+cmMvYW4yHIIMsrft1POIfuFvWDXmFh+6dl.GQkLijjz.wB5BRWK7+ZfqG3fGwsw6kzooWRRYfEz61lEvqD3V.dMLd2Fi6DvwWFSJIIM7rfd20y.3ZA9f.aSIsMeq.OtRZaIIogfEz6d9UAt.fuIvdTxa6s.3cUxaSIIM.rfd2wlA7N.tIfmWE924X.12Jb6KIo9vB5se8hq0aF3jA1zJ9u2j.u+0+2URR0DKn2t8a.bE.eZfETi+cO.fitF+6II04YA81oGGvGG36BreYZNbF.Sko+1RRcNVPucYt.uARw05wRde8cQqetHIoZfEzaOd1jhq0yfT2lGAmD06o5WRpyxB5Me6Fv+BvEAryYdtrw1Lf2btmDRRcAVPu4ZqH0M4WOvgj44R+7f.uaROw1jjTEabh5SkGyB3kP5dJeay7boHeAfSD3Gm6IhjTWgEzaVd5jdHprm4dhTfa.30B7Mx8DQRpqwS4dyvNBb9.WJwrX9cC7p.1arXtjTV3uPO11LRWC5SjXdOcuZfOBvaCXYYdtHI0oYA8XZBfW.v6AXgYdtTjuAoSu9Mj6IhjjrfdDsujtN46etmHE3GS5LF7Ex8DQRROLuF5ww1C7w.9dDyh42GvaA3IiEykjBG+E542bAdM.mBwIg21PqizC2k2DvOMyyEIIU.KnmWOKf2Gvtj6IRA9tjtN4WYtmHRRZ54obOO1UfuBvkPLKleG.GCvSCKlKI0HXA850VR5Wj+8ANzLOW5mUBb5.KF3umzoaWRRM.dJ2qGyB33.dmD23Z8KBbB.+nbOQjjzvyB5UuChzsg1dk6IRA9uHccx+54dhHIoQmmx8pyNB74AtLhYw7kQp652KrXtjTim+B8x27.No0OhXbstFd33Z8ty7bQRRkDKnWtdr.WKvhx8Do.eSRmd8+ybOQjjT4xS4d45tAttbOI5iaE34A76hEykjZkrfd46DHc6eEA2GvIC7j.tvLOWjjTExB5kueDotZOm5EWq6Jv6B3Ay6zQRRUMKnWMdW.KMS+suJRObWdQ.+jLMGjjTMyB5Ui6E3sVy+MWJvwB7TA9N07eaIIkYVPu57IAtlZ3uyJANCRYB+mDXs0veSIIELVPu5rVR2hXUYdneQ.6NvaD3WTg+cjjTvYA8p0U.b9Uv18FANDfi.3GVAaeII0vXA8p2IA7KKos08.b7.6IvWqj1lRRpEvB5UuaG3LGyswZ.9vjtN4mCvpG2IkjjZWrfd838.7+Nh+2do.6CvqD3mWVSHII0tXA85wCPpw0FFKA3n.dF.e+xdBIIo1EKnWe9r.+6Cv+d2Ovo.ra.WPkNijjTqgEzqOqizswVQ2m3qC3yPJtVemXbsJIogfEzqWWEvmpO+yuZfC.3OgQ+ZsKIoNLKnW+dyjdJnAo3Z83.9sXvNc7RRR80ry8DnC5N.NMfsmzoV+dy5rQRRsBVPOONqbOAjjT6hmxcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.SJNo5wcC7OUhaueZItsjTKfEzkpG2LvQl6IgjBkkB7cKos0jSP54y8DkzFDROzQtqRZasi.O0RZaAoCdWVIt8jjT9MafUUxaysBX4k71rJMUz+E5215GRRRZZXSwIII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BXAcIIoV.KnKII0BTEEzec.yoB1tRRR8SzetjTaVKv5J4wMAbX04Ngjj5jNXfe.kecrsrN2IJASAUSA8diKAXWpq8FII0YrS.+yTc0urfdeFqD38BL+5YeRRRsXaNvoC7fTs0trf9zLVJvwgMhmjjFdSBbL.+TpmZVVPe.FWCvATC6bRRpc3oA7codqUYA8AbrVfyCXgU9tnjjZp1AfOE4oNkEzGxw8C715MQjjj.1Tf2Bvuf7UexB5i3XI.GcktqJMXdt.+Z4dRjYaMviK2SB0Y8bA9wj+5RVPeLGWFvdUk6wRE3WG3aP58gWPlmK41GBXE.mDvby7bQcGa3ZvHLrfdILVMvGAXaqt8ao+eOVfO.o22sguO72NiyobZO3Qdr3V.d1YcFo1thVCl6Qirf9ZH+G3523dvXjUUmYC7pAta5+6+9O.lU1lc4SQ+BouJvtkw4kZelo0f4dzHKneH.WG4+fWQiaB3PqnC.pa5fAtAl4268xy0DLSdNL8GOdHf2OvVkqInZMdlLXqAy035H0XdMISAoDbaq.dU.2I4+.YQCiQVMtdhLbQE4cQy6aoOp1DfeDC1wkeFvqft4YvPimgcMXcOtKReQ9l36s++Kn2ar8.mIo3ZM2GX62Xkqe9sEUvAC0dMNQE4Ykg4aN7lX3O17eP2sWCzvYyAd2T8w05nNdHfyll8Wf+QUPu2oXXWH8Khy8A4hFFirZPLIveFiWTQtRfEW2S7Z1iG3dYzOF8OB7qV2SZ0HLAi+Zvpd7uP6n+PJrfdOGJoqgctOfWz3pA1+R5fgZWdpTdQE4kTyy851Gmw+XzC.7N.1rZdtq3pLWCVEiaA32ux16qeyXAcH0k4uNRccdteAneCiQVsg1Af+AJ+aGyCoN2IpQ+FTt2oK+O.+Qj9kYpa5WgpYMXYMVAvaf1WFKLPEz6YaIc+gGs6UvdCiQ1tspNpHuQZe2BkS.bETMGu91j9xBp6HBw05zMVCveGodEqMZnJn2ydQJQ2x8KNEMVBvQM7GKTCVcEUjul5ZGpl7Bod9.TiQ11umCC9cIQNFWAs+uf4HUPumilTwyb+BUQiKEiQ11t5NpHWFoTspMXd.2F0yws15o3TwKtV23QW5R.MVEz6sANURmt6b+BW+FqF3CiwHaaSunhbUT+um5CTC6e0gSk5+XmwHa6QNWCNHiG.3sS2pIMG6B58rPfOKwsIHtGfWKsuqAZWyrIE.R4LpHWEvtW06nUrERd+R3skaSntnHrFblFc0aixRqfdOG.v0P9eAsnwMR6saka6hTTQ9uVw6qUsyi7eLzXjs4IRqA62nqGzQkdAcHElGuDhcLxdw.6bIrupp2SD3KP9eOyFONhpbmtBseDqyjVSNpM6Jh5ZvdCih3jJofdOyG38RriQ1y.iQ1nJ5QE4MQyqQalD3pH+G652nq+qqhnnuFzyxyiTkVPumlPLx9hwXjMJLpHqNyh3e8OOe5lW+yHw0fMS0RA8dNLhcLxdUXLxlaMgnhrMzk11gxpHOUfqj7+df19ZvpPsVPGZFwH6mAXAU0A.0WFUj4g2CwpGWC17U6Ez6Y6.NWJ2LjtLG2GvofwHaUqoDUjs8jNqtRZuQcbE.6aks22sso.uYh8ZvONs+0fkgrUPum8lXGir2JvQVY68caQOpH6ZYQdS4KW0Vyg6bv0fsKYufNjNcZOepuXnbTFeKf8rpN.zw7qC70I+ulVznqeZdqpmVck0XE.mHdpWGG6NweM3eLc20fipPTPum4Q7iQ1ODv1TUG.Z4dr.+sD6Fwxmm2OrlPCJ1ldVVWGbMX6VnJn2yhH1wH6x.NdLFYGTFUjMWSR7u8k9J3suzLw0fcCgrfdOGHFirMcOSf+Sx+qUEMLLSFLaNvoSrCXjyFXKqpC.MX+t3ZvthPWPGZFwH6EgwH6Fynhrc5IB7OS9e8qngwH6C6IfqA6ZBeA8dlOvYQ5ahm62H1ugwHaxiAiJxtfClX+P535.d5U1der8X.9qv0fcQMlB58rXfuD4+MkEMtCfiktWLxNAveJvOg7+ZPQiuJvSppN.zAMafWMw95xd9.6XUc.HXbMnZbEz64vAtYx+aPKZbUjdpV0E7agQEYWVuXjc0j+Wq623A.9KIcWzzVE80f+23Zv5PisfNj5x7WOvxI+ugsei0B7oo8Fir+J.+8D26FgU.bR38qbcI5wH6sC7BoccuM6ZPsgZzEz6Y6.9nD6Xj8jo8DiraBFUjpXFirUOWCp9oUTPum8A3xI+uYtnwsRyOFYMpH0fXSAdqD6BNeLZlwH6eHweM3Sox160zoUUPGLFYqJFUjZTrC.eJh8oDtoDirtFTyjVWA8dlGvogwH63ZqI1QE4uDiJxlfmFv2i7+9khF+.haLxt0.+M3ZPMyZsEz6YQ.eNh6uPXY.uFR2BPQxrA9KH12RRFUjMKSBbLD+XjcWqn8+gUu0f+bx+wkhFW.tFLRZ8Ez64.AtVx+BfhF+W.+dU1d+vI5QE40iQEYSlwH6LqIrF7YTY68ZT0YJnCoegvKkXGireQfcppN.LCdB.W3.LGy0vnhrcYmH898b+9phF2EvKi588aMg0fuRbMXT0oJn2yVB79HtwH6CB7dn9hQ1nGUjqB3uFiJx1pClzYnJ2uOqnw0AbPU1deRu0f+xLuu5ZvlsNYA8dVLvWl7uXonQUGirFUjJJlModIYYj+2yUz3yS4GirtFTkoNcA8dNbRc4ZtW3Tz36QpKgKSMgnh7Onj2mU7sM.eP5FwHqqAUYyB5q2bANAheLxtCi49YziJx6kTTQtIi49oZ11CfuI4+8iEMFmXj8wC7Iw0fp7YA8MRSHFYeqL7uNYTQplnmGwNFY+2XviQ1MA3MQpfYtm2EsF7SfqAaxrfdA1GRKVy8hrhF+XReX2f3OD3GFf4bQi+cLpHUw5Eir2G4+8pEUHblhQVWCp5fEzmFS.7BHc50x8BthFeSRmdx9Y2A9WCvbrnw+KFUjZvE8Xjc4jtrcaXLx1DVC9mfqAaKrf9.nWLx9.j+Ef8arZRMRTuXjsIDUjuSLpH0noIDiruHbMnpeVPeHrijt0Ux8hwhFqfzGlrh.LWJZbA.+ZC6AdoMRuXj8NH+umtoMbMX6kEzGAGDovlH2KLaRCiJRUE1bRgvTTCEoHMbMX6mEzGQyhTrPdWj+EpQdXTQp5PziQVWCp5fEzGSQOFYy0vnhT4vuGwNFYq60fmCtFrKwB5kjckzidwbuHNBiuFFUjJeZBwHqqAUUvB5krmEwNFYqxgQEohjnGirtFTkMKnWAlKvIRbiQ1xdbu.uQLpHULE8Xj00fprXA8Jz1SJAohZLxNtidQE4iurNfIUgdd.2J4eciqAUUwB50f8kXGirixvnhTMQaJvISbiQVWCpwgEzqISP5oyTjiQ1AYXTQp1fEP5oWXTiQVWCpQgEzqYyizyS4nFirEM5EUjOlx+PhT1reD6Xj00fZXXA8LYGANex+GRLHCiJR0lMIvwRriQ1+IbMnlYVPOyd5D2Xj0nhTcIaAoXjckj+0d8FeefempbmVsJVPO.lEvKm3Dir+bLpHU20NAbQj+0f+43ZPMbrfdfrk.mM4KFY6EUjacUuiJ0.jiXj00fZbXA8.Z2n9iQ1uFvStN14jZPlCvwS8DirtFTiKKnGX+9.2BU6Gh7CANh5ZGRpgZa.9PTMwHqqAUYwB5AWuXjcETteHhQEozvaOA9V3ZPESVPugX6A96X7iQViJRow2QxnGirqA3ShqAU4yB5ML6KvUvn8AIeGfey5eJK0JMECeLx5ZPUkl5+CcDZj5LFOo9I.....IUjSD4pPfIH" ],
									"embed" : 1,
									"forceaspect" : 1,
									"id" : "obj-76",
									"maxclass" : "fpic",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "jit_matrix" ],
									"patching_rect" : [ 25.166660308837891, 22.044245872497555, 102.133331298828125, 53.92639892578125 ],
									"pic" : "acids.png"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-30",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 4,
									"outlettype" : [ "", "", "", "" ],
									"patching_rect" : [ 1001.66668701171875, 29.333333969116211, 56.0, 22.0 ],
									"restore" : 									{
										"gain~" : [ 130 ]
									}
,
									"text" : "autopattr",
									"varname" : "u531005133"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-29",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1229.0, 104.666671752929688, 29.5, 22.0 ],
									"text" : "1"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-23",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1191.8333740234375, 104.666671752929688, 29.5, 22.0 ],
									"text" : "130"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-19",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1191.8333740234375, 75.333335876464844, 44.0, 22.0 ],
									"text" : "launch"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-15",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1055.0, 104.666671752929688, 29.5, 22.0 ],
									"text" : "0"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-14",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1139.00006103515625, 104.666671752929688, 29.5, 22.0 ],
									"text" : "0"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-26",
									"maxclass" : "newobj",
									"numinlets" : 2,
									"numoutlets" : 2,
									"outlettype" : [ "bang", "" ],
									"patching_rect" : [ 1099.66668701171875, 36.831996917724609, 34.0, 22.0 ],
									"text" : "sel 0"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-25",
									"maxclass" : "newobj",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "int" ],
									"patching_rect" : [ 1099.66668701171875, 11.333331108093262, 40.0, 22.0 ],
									"text" : "active"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-24",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1099.66668701171875, 104.666671752929688, 29.5, 22.0 ],
									"text" : "0"
								}

							}
, 							{
								"box" : 								{
									"hidden" : 1,
									"id" : "obj-22",
									"maxclass" : "message",
									"numinlets" : 2,
									"numoutlets" : 1,
									"outlettype" : [ "" ],
									"patching_rect" : [ 1099.66668701171875, 68.666671752929688, 35.0, 22.0 ],
									"text" : "reset"
								}

							}
, 							{
								"box" : 								{
									"angle" : 270.0,
									"background" : 1,
									"bgcolor" : [ 1.0, 0.972549019607843, 0.874509803921569, 1.0 ],
									"id" : "obj-40",
									"maxclass" : "panel",
									"mode" : 0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 256.533313751220703, 166.166671752929688, 237.183326721191406, 145.252277374267578 ],
									"proportion" : 0.5
								}

							}
, 							{
								"box" : 								{
									"angle" : 270.0,
									"background" : 1,
									"bgcolor" : [ 1.0, 0.972549019607843, 0.874509803921569, 1.0 ],
									"id" : "obj-47",
									"maxclass" : "panel",
									"mode" : 0,
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 16.349987030029297, 166.166671752929688, 231.183326721191406, 145.252277374267578 ],
									"proportion" : 0.5
								}

							}
 ],
						"lines" : [ 							{
								"patchline" : 								{
									"destination" : [ "obj-9", 1 ],
									"order" : 0,
									"source" : [ "obj-10", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-9", 0 ],
									"order" : 1,
									"source" : [ "obj-10", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-10", 0 ],
									"hidden" : 1,
									"source" : [ "obj-14", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-23", 0 ],
									"hidden" : 1,
									"order" : 1,
									"source" : [ "obj-19", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-29", 0 ],
									"hidden" : 1,
									"order" : 0,
									"source" : [ "obj-19", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-14", 0 ],
									"hidden" : 1,
									"order" : 0,
									"source" : [ "obj-22", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-15", 0 ],
									"hidden" : 1,
									"order" : 2,
									"source" : [ "obj-22", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-24", 0 ],
									"hidden" : 1,
									"order" : 1,
									"source" : [ "obj-22", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-10", 0 ],
									"hidden" : 1,
									"source" : [ "obj-23", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-26", 0 ],
									"hidden" : 1,
									"source" : [ "obj-25", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-19", 0 ],
									"hidden" : 1,
									"source" : [ "obj-26", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-22", 0 ],
									"hidden" : 1,
									"source" : [ "obj-26", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-37", 0 ],
									"midpoints" : [ 665.5, 211.0, 663.0, 211.0, 663.0, 340.0, 939.0, 340.0, 939.0, 343.0, 943.5, 343.0 ],
									"order" : 0,
									"source" : [ "obj-28", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-8", 0 ],
									"order" : 1,
									"source" : [ "obj-28", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-37", 0 ],
									"midpoints" : [ 665.5, 342.0, 939.0, 342.0, 939.0, 343.0, 943.5, 343.0 ],
									"order" : 0,
									"source" : [ "obj-34", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-8", 0 ],
									"order" : 1,
									"source" : [ "obj-34", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-37", 0 ],
									"midpoints" : [ 817.5, 339.0, 943.5, 339.0 ],
									"order" : 0,
									"source" : [ "obj-36", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-8", 0 ],
									"midpoints" : [ 817.5, 340.0, 665.5, 340.0 ],
									"order" : 1,
									"source" : [ "obj-36", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-38", 0 ],
									"source" : [ "obj-37", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-8", 0 ],
									"midpoints" : [ 511.5, 340.0, 665.5, 340.0 ],
									"source" : [ "obj-4", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-8", 0 ],
									"midpoints" : [ 366.666660308837891, 333.0, 665.5, 333.0 ],
									"source" : [ "obj-42", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-42", 0 ],
									"source" : [ "obj-44", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-46", 0 ],
									"source" : [ "obj-45", 1 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-8", 0 ],
									"midpoints" : [ 34.666660308837891, 333.0, 665.5, 333.0 ],
									"source" : [ "obj-46", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-8", 0 ],
									"midpoints" : [ 266.033313751220703, 333.0, 665.5, 333.0 ],
									"source" : [ "obj-50", 0 ]
								}

							}
, 							{
								"patchline" : 								{
									"destination" : [ "obj-10", 0 ],
									"source" : [ "obj-8", 0 ]
								}

							}
 ]
					}
,
					"patching_rect" : [ 204.0, 99.0, 59.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"tags" : ""
					}
,
					"text" : "p transfer",
					"varname" : "transfer"
				}

			}
, 			{
				"box" : 				{
					"id" : "obj-6",
					"maxclass" : "newobj",
					"numinlets" : 0,
					"numoutlets" : 0,
					"patcher" : 					{
						"fileversion" : 1,
						"appversion" : 						{
							"major" : 8,
							"minor" : 5,
							"revision" : 0,
							"architecture" : "x64",
							"modernui" : 1
						}
,
						"classnamespace" : "box",
						"rect" : [ 0.0, 26.0, 1306.0, 721.0 ],
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
						"showontab" : 1,
						"assistshowspatchername" : 0,
						"boxes" : [ 							{
								"box" : 								{
									"autofit" : 1,
									"forceaspect" : 1,
									"id" : "obj-7",
									"maxclass" : "fpic",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "jit_matrix" ],
									"patching_rect" : [ 47.0, 106.0, 535.0, 156.122727272727275 ],
									"pic" : "/Users/domkirke/Dropbox/code/vschaos2/assets/logo.png"
								}

							}
, 							{
								"box" : 								{
									"autofit" : 1,
									"forceaspect" : 1,
									"id" : "obj-6",
									"maxclass" : "fpic",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "jit_matrix" ],
									"patching_rect" : [ 290.0, 580.129851114684016, 240.031645569620196, 128.559322033898269 ],
									"pic" : "/Users/domkirke/Dropbox/code/vschaos2/acids_white_bg.png"
								}

							}
, 							{
								"box" : 								{
									"autofit" : 1,
									"data" : [ 51127, "png", "IBkSG0fBZn....PCIgDQRA..BPM..DfpHX....vJsOM2....DLmPIQEBHf.B7g.YHB..f.PRDEDU3wI6cmGeTUc2+.+y4NyjMHIS.DPTHAWeTqjgE05Bj.t7nVkDo0ZWrD.0m15BKZ6SstPTn19TsBRe5S+UURPTa0hK.ZE2.RBZcEHIHKJaIALhrFRXOIy86u+XlILYxLIyx8NKIed2W2Zxj4dNeuKCy264dtmC.QDQgk7yOeA.l4BQDQI.zh0A.QDQDQDkHiITSDQDQDQQ.lPMQDQDQDEAXB0DQDQDQTDfITSDQDQDQQ.lPMQDQDQDEAXB0DQDQDQTDfITSDQDQDQgIQDESnlHhHhHhh.LgZhHhHhHJBvDpIhHhHhnH.SnlHhHhHhh.LgZhHhHhHJBvDpIhHhHhnH.SnlHhHhHhh.LgZhHhHhHJBvDpIhHhHhnH.SnlHhHhHhh.LgZhHhHhHJBvDpIhHhHhnH.SnlHhHhHhh.LgZhHhHhHJBvDpIhHhHhHhHhHhHhh9DQTrEpIhHhHhnH.SnlHhHhHhBerEpIhHhHhnHASnlHhHhHhh.LgZhHhHhHJBvDpIhHhHhnH.SnlHhHhHhh.LgZhHhHhHJBvDpIhHhHhnH.SnlHhHhHhh.LgZhHhHhHJBvDpIhHhHhnvGmoDIhHhHhnHASnlHhHhHhh.LgZhHhHhHJ7wt7AQDQDQDEIXB0DQDQDQTDfITSDQDQDQgOk0XcDPDQDQDE+SDQ44mUJkDKik3LJUW+dHhHhhtb+E21qt5pOmMu4M6X8qe8WlRoNyxJqrgpTpzgq6vpUGNbXadyadVhgwYRUWc012zl1Te+xu7KG..5yJVwJ5qllVZZZZIC.nqqeBkRcB.b3d26d2zvF1vZLojRpgq5ptpCNnAMnFOiy3LNhRoZMVsMDq49XcJqcsqMqssss0+MrgMz+Vas0S4C+vOLKcc8zAfUMMMKJkpY26KOR5omdSibji7fm3Dmng7yO+FF3.G3AxM2baB.mfI5E4DQTM1XiY84e9me9UTQEisolZ5xqt5puL2e1yy64D.Xc4kWdue1Ym8GeIWxkr5K3Btf8nTJ8nbrlxV1xVNsctycdAkUVYC2hEKWP4kW94KhzWkRkE.zAv9.v2.fpthq3J9hzSO80L7gO7seMWy0rOiHdEQRlITSDQgoErfEH0Vas98uIh.UD1lEO5i9nF1+FcM0Ti7bO2yYTEWGjSN4fIO4IGQwqHhkO+y+7y6sdq251Ku7x+EUTQEI2UqS94mOJu7xiZeWlHRlUVYkW7RVxRlPEUTwOqhJpnWQZYlSN4fK7Buvu4ltoa5Ytpq5pd8AO3AuotyIX6NA5LWwJVwktpUspoTQEUTPEUTgsNacTJEDoyyS1tc6H+7yukQO5QunwO9w+hm0YcV+akRcHiL1MCEWbwl1E.Dpetrt5pKqm7IexeZEUTwCWc0U2e+8d5riEYlYl5ETPAO4O5G8id5q65ttsaVWbiHRZKdwK9ZW5RW5CTQEULR+8uCGLmyjYlYpmWd487SXBS3uTTQEUc394NQjTBm0iHhH.je94K.vLWLLkUVYlZr5deQXY8qe8C7dtm64wxImbhp0avRDI4su8sWvTm5T+x.EitSbvPVFyXFiyRKszGnlZpwtYusEMIhz6JqrxIWTQEsa61sa3mC56w.GNbHyctyc4e0W8UN7tqJDGJl+4xku7keZiYLi4M8c86ryq6py4yN6r29y9rOa9hHF1yqW80We+l4LmYIlw4O1sa24Tm5T+u2zl1T5HDIhjZjtsQDQ8XM1wNVS6KBcuXXV4JWooFqt2WDzDQTkWd4mWd4k2mDI0qYlPsHRpqbkq7A78BmLxjm6rE61sKybly7+UDo2l01XzfHRlkVZo+YGNbzoau9a+pQruVoTRQEUzN11111niSSr1zNGpq97wN1wNRM+7yuj.s99t+ObNdjat4t0ku7ke9QzNHQRcpScp+Mybek2K28ce2OjHRRgP7kVjr8QDQ8nwVnN3+hauUd4ke14kWdUEsq2fkHh1xW9xu0nvw2NcwSxK1saWdvG7AuKQjDpAR.QDKqXEq3WEN24AyZonhJZcacqa8rM6s8PTL4ykyady66lYlYdTyr98d4dtm64+SDoS6ZOcXGiHpRJojaHyLyr4nUb5YIyLyroW60dsKJHiyD5K5kHhhoXB0A2Wb6w9129xX7ie7ubztdCE0We88a7ie7q2HiQiZI6ryt924cdmyxH2dMKaXCaH6wLlwTOhC1u4ukhKt3GON5BThpetTDQcq25s9eal0afVF1vF1t10t1ke6a19INSovBKbowh3z6koO8oO6tpaqHhjQvrMQDQjevDp67u31CQD0S7DOwDLi98nQlP8q8Zu1UaFwX3t38sW26ed5Se5OfQ1uTMRhHp4O+4+yxLyLi46+5pEGNbriUu5Uepl2difVT6ykKZQKxxvF1vdQueOQqtvjmkLxHCmqd0q9B6rcHe7G+wmW1Ym8gilwUmsLwINw2tyt.LQjtUOuCDQTTESnt8ews+5epaZSaJ87xKuxMy5MR22Hhnt669tennchEQxxvF1vVdYkUVb0HKfHh1Dm3D++gtH1iV6mUJUWVW1saWdlm4Y9tl2dkfho94x1pDQrlat49dAy5Y1Gira2tr5Uu5w0gcDhnV8pW8cEOcgsdVxKu79j.kTsHRe82qSDQTPfITexkwN1w1gDpW9xW9XM699XjlPs6j.eFyLFizk.kbyvF1v10l27liKtUytSV6sPbv9qtZwe6Oehm3IJxT1wDbLss07xKOA.PDIk7xKu056eOZbwMA5gM0tc6xZVyZlPa6DDIkRKsz21rimHYonhJ5s72cGRDIn5FKDQD4GLg5St3NgZa.t9hwhKt3WzLqOOKQRB0hHZde6uSjZgZOKYjQFMr5Uu59Et6CLBhHVc3vwpBTLFqWB1g9sINwINYyX+SPvT+7gHRuKpnh1tYVOg6RN4jizPCMb6hHmcokVZCdd834OKNm4Lmh6vAPQhG55PDQThIlPcG9h6As28t2wVPAEzkib.F0WXFtITKhnF1vF1BLy8Il8hmtzPlYlYS6ae6KlzR0KZQKxRvlLc7bRRdVJt3huUCemTWyz1dxO+7kRKsz8al0Qjt3vgCoxJqT7zMORDNOYMqYMircG.EYHc7vJQDQAElPc6+h6ZpoFoqFqgMi5MT2WHhnJpnh98AS4GnubOd6K8c3vwNh18oZQDUt4l6BCk3LVreKXpSueOO2y8bWrguypyYZa64jSNR7X+Q12k3sOO0UKCaXCqAuGB.EQNS+bbkHhnfASn9jeQXr5KtCmDpevG7AmbzNNiFKie7ie4QyItjBJnf6y65OQKonNYw45V25FfgtypyEq2d4RXrTRIk7vsc.TjHZhqgHh5QiITG6WB0DpW4JW4Hi0wrYt7m9S+ooEJ6OBWEWbwmerZaLZrjc1Yuin33TcLe6kKg9hc61EQjzA.DQFgeNtRDQTvfITG6WBkDpOvANPlYmc1M2MpkT8aqBWe80ap8myErfEjB.ZpyhgDwEe2NlwLlwSXf615Lw7sctDdKkTRIOB.fHxn6vQUhHhBNLg5X+RvlPsHhZpScpehm0q6RRf9aIu7xail4D+xfG7fiqGlAMxk28ce2uiQseqSDy2N4R3s3vgCQDIIQjq2eGXIhHJHvDpi8KAaB0aYKaY7w5XMZtL+4O+BCl8Kgpe8u9Wetw5ssn4Rt4lasQgYkxX91IWB+k0rl0bkhH+r3k4wdhHhHSgHhsIMoIsnXcbDMM6YO6WTDwtRoZ0nJSQDsLyLy21nJuDAUWc0YufErfBAvqGqiEJ9zy+7O+iNhQLhxh0wAQDkvpmdKTGOzsIBlVnd6ae62brNNilKdNtTRIk7C6p8MghexO4mL1X81VrXI6rytYS9ATLluMxkPewymyb2sOb5uCrDQDED5omPcmsDsR1tqRn1cemdWQys8n8Rf1WOjgLjFLptqvhVzhr.f8Fq2ViF6272xJVwJFuQreL.h46K3RjszPCMX58KHhHh5ARDoCulRYbCQxgPYMn23MdiAZXUbHHR1dCk00e6qA.1wN1g8UtxUddgcP3kMrgMLZ.D0lhyMxyUBj.seye9y+4+bIQg9RcbunwwkDQUUUUf8gZhHhhJBkDXLpxZMqYMWcs0VqgUugBuiQkRERa+F09pm+4e96A.+hHoLDQT4jSNOigDP9vSBZ9t8ZjmqDt79X1RW5R6WCMzvE.fuH1FUQedueHZdboq9LSn9YJyT4kWN5we0VDQDEaDMZsqm+4e9+KSuR7Rf1lhUew+BW3B+4EWbwQTims3Eu3ynt5p6rMpXxahHA09l.se0LOGx23ZwKdwOnoUYwwhUm61U0a7Rxz..0UWcLgZhHhhMB2uPLXShRDwxpV0ptzvpRBSwSeIuGm1ocZmajr9KYIKIpL6K1YBz9UQDSMoZuK627MeyaQDwloUYT.Eu2USps1ZYW9fHhn3CNb3.4me9XHCYHekCGNdCcc8MekW4UtG.fpqt5zZngFN6JqrxQut0stqdIKYI3fG7fcZ40XiMlQUUUUTI18HmbxAETPAH+7yeMomd5K6JuxqrtFZngVqrxJGbs0V63W0pV0EsjkrDzXiM115X1255O5i9naB.aHbVWQDqYkUV2iAGRcobxIGTXgEhQO5QqmSN4ToCGN1UM0Tywqqt5Fbc0U2HV0pVkMOmCXl667trKqrx..FB.1loUgQQtOOENb3XKCaXC6i6Se5SCaaaaqu6XG6XzUWc0YuvEtPDs+7Sf343PgEVHxKu7fCGNNP1Ymc0CcnC8Dae6a+zps1Zuf0st0oszktTTd4kG0iut5eKhHhnNAGkOh7k7yOeozRK8vG3.GXZhH4DLCOYhHZhHm5q9pu5sUbwEui.89VwJVwEX1i1HJkRTJkX2tcozRKc9hHmamsMHhjxANvA9IEWbwM6a4XVw3PFxP1qHRX0DeKaYKa3l49OeWxImbjRJojMKhb8hHo6u3VDQIhzOQj6dtycthc61iZw2JVwJt4vY+XWHp9YtBKrPolZp4MEQtf.ctp6Y+uKZEqXEehCGNhpwWfh4ssss8ThHY6uX184DoIhbIkUVYuWT3ea1eKDQDENXB0g+xjlzjjsu8suZQjgEIidBcVhhO7C+vEDM1VtvK7B28N1wNNsPLt60ZW6Z+jnUxf6ae6KiPI97n3hK92GMhO.HSaZSyoHx+Ynj7uHh80t10tdeS5ynt.EeKm4N24NmPX2WPuYDsVJszR2uHRP2Efbmn5kWTQEc7nYb58xS9jO4GJhjUvFyti6yqnhJ5nQqXz84IDQDENXB0g9R94muTUUUsCQjKLba0zf0jlzj9Ul81SN4jibnCcnADNwmHh00t10tVyL97jP3y8bO2EGFwmJu7xqI+UdF8RokVZChHmRnFitiSaqYMqY01sa2zG+yKpnh9rvIF6pMgnwRwEWbshHoFVAnH8e7ie7GNZEqdVJpnh9DQDKgYLe5SZRSJZFuDQDENXB0mbIXRjYtycthHxuIZMd9NlwLlWvr2lVwJVw+SjDihHoOyYNSmQRbFLKEWbwOTXDaYjYlYZ5IhLm4Lml20t1U+C03ymXMkRKsz8a1wZd4k2wij3LPguYujSN4HgZq75q8su8c9l0cTweeVK6ryV1yd1yoFIw792+9u4bxIGSe+q6EhHhBGLg5f6KJsa2tTYkUdbQjKvH2lBBqyH2V7cI+7yWDQFbjFj6e+6+ma1c8i7xKusGpw0W9ke4+gQGG9l3TgEVnHhb0gZr4OhHiLZj7jIbAgldLufErf6yHBzYNyYt3n0rf5blyb1XjFuhHZKXAKX6vqy8Lw3mHhnvASn1+Kd+EV1saWV6ZW6tEQ5iQt8DjZ2C9mQur3EuXCI4JQjzL6aMsCGNjP8VmWd4kOAiNN78bissss8gFUW+QDQaNyYNld2RvDF57L03MqrxRBk9McmYe6aeeWyNd8rru8suIYDwrHxniFOqBbbnlHhHCkmg3J61sixJqrCL7gO7yVoTGHZFCEWbwZ.vTGyfKrvB+.kRoGokiRoNZAETve2Hho.w8vel8PYcV4JW4vM53v6ggthJpHbFmwYLYi5A5RoT54kWdy2HJqNyq7JuRB0PNbd4kG.v2ZDkUe6ae+pBKrPinn5T4me9nu8suepAUbeRzHlYB0DQDYJJojRzc3vw4pTplhAUuo98a4me9..uuAVdKvnJqNQHMRjnTpKxrBD.foMsosI.rUirLGwHFwJraOjttgP1INwIRnlbWbmP8QMnh6PtKOSk65XWFQYoTpVF8nG8lb+yFQQ5WLgZhHhLbSe5SGSXBS3xUJ09hE0eN4jio1Jh4jSN.t5i1FB61s+kFUYEHacqaMmP48WUUUcYFUc6ahLNb3.CcnC8NMggarZc3vgAWjs2.G3.SnRn189iVMhxRoTsNrgMrH9txzUbGyGwnJuQLhQ7wFUYEHLgZhHhLT1saGEWbwOsRo9jXUL3zoSSKoGkRgryNa.f5Mvh8.ta0aSyN24NC5GfRQDsFarwzMp512Yyv7xKuV.vGZTkuWNnQ2B09dw.IZsPc1Ym8QLxKbY3Ce3l9LEo6igFxEA..3vgiZ.534gFoDp9ADQDQw+lyblSK1saeZwxXXm6bm1.B7z5cjLce6050P3Fe9wILvxxuz006UH71SYtyct9aJUVWWuiMPolllSO+rHh+ZAy18Z4jSN+VkRYXIL4ki3vgCrjkrDCq.EQZ24KVsZMgJg5gNzgZncqlrxJqs.fy1HKSeke94+sF7cu3a8bgQlUR0LgZhHhLL1saGSdxS9mqTJSOAwtPR.A9KOMnuT0vtkztef5pA.C0nJS+HfSS69IdNJ.L0IdGSRylQBSdWlVrXIgJgZXr2IE.fcZvkm+7UFb4seyr0oAXB0DQDYPTJEl1zlF.foNhUDjRJJTGF5j7wblybVYSM0zsEhqVKhHMCfCAfFAvA.vtAv2JhTuHRs.nNQj5txq7J+ZiLdiSYFs5c6nookvjPs6tNggLBe3k8Zvkm+TmAWdl9CFMSnlHhnHlmaI9jlzjdVkR0brNdN5QOZxQgpoEirvF4HG4sCfa2HKydfb10ukHSqs1ZBSB0Ce3CGv0EYYj5P+.xDrGCt7NrAWdc.enDIhHJhIh.GNbfbxIm+2Xcr..jVZoEMRn1zSdiBYl9HPQxImbBSB0t6lCMZvEazXXvznGcfNlAWdc.SnlHhHCg6QohsDiCC..nqqyDp6YxzSntkVZIQ6t6eHCt7LrmcfNgQeQ.l9yzASnlHhHCwXFyXNlRoLz9Ub3pkVZIZzGpM2mxIJjYBiq0cfYNjLZRL5t6fo2Zuv3uH.lPMQDQIFb3vQYw5XvijSN4nQKTyDpiOYpI7oTpDsVn1naQ4nwEMaTyridXnOuC9CSnlHhHCwPG5PWSrNF7Bag5dtL5Q0BekPjPsWSHMFcBvQigDSi9hhL+Q+EytBHhHp6O2SUvl9LnVvJJ0GpYB0wgb5zoYOc2mPjPsWi6xFcB0QiQwGiNoclPMQDQw+bOd2tqXcb3gllVzHgZJNjllloNNIawhEKlY4aBL5DfM8tOAL9DpM8GVUlPMQDQQDut0xF83cajHZzkOnXLQDkHhlHhEQDahHQiKjJgnEp8hQmPso2Zuv3SZ2zGQdRzNofHhn3LdcqkM8IOgP.SnNNlHhku7K+xzpu95yn7xK2tMa1r+Iexmj0QO5Qs6zoyr95u9qyr1ZqMS.jI.rCfLb+esCf9lat41mrxJKswN1whbxIGjc1Y2VYuicDzyv5gqDsbmL5jSSDSn1zag5DsSJHhHJ9kQ+j4G1Zs0VM8VpLZLDs0cfHhB.Y89u+6eQqZUqpvUspU8CTJU+Bl00yLvom+qGUWc0lU3FLwThVtSFcBvQiDpM55fITSDQT7O2c6inwS+ePwpUqIZiUvc6Hhj7q+5u90WXgEN2ktzklcWuFnCIN64m8905r2ezfRoRz5trIbs1KL9tnASnlHhn3WdRnwcRMQiGVofhSmN4CkXLhHRZO7C+vSKqrx52evCdPyttL0xO.RzxchsPcTXD4IQ6jBhHhhi3SBMQiunMXw9PcTlHhkG5gdnaOqrx5u4IQ5PsEjiQIHGpRzxcJgq0dMg5fITSDQTBCS+IoODvDpihd+2+8OibxImxqqt5Fr2udBRBxgjDvt7gQ+4xnwmyM55fITSDQTBinQKWETzzzXB0QAhHpoMsoMoq9pu5Ri0wRTThVtSIhsPMSnlHhndrhaRnFrEpMchHZETPA+uuwa7F2YrNVhlb5zYh1D6RBW2m.IfwLSnlHhHiRbSB0JkhixGlnhKtXMGNb7hUWc0+3XcrDsooo0SOg5Dw9PsoKQqe.QDQT7q3lNLaTZFyqGIQDUkUV4SEnjo8Zlyr6pDsFiLQLg53l+sjfESnlHhHiRbyWBxVn17L8oO8eva7Fuw8Dn+d2wGDQuwt7QT4y4Fccvt7AQDQTnRDgITaBV5RW5.JnfBVTrNNhkzzzRzZLxDwVnlc4ChHh5wJtooIYKTa7Jt3h0l5Tm56FqiiXMkRkn0B0Ibs1KXB0DQDQwdrEpMd555WYc0UWtFU4En9Zs+dceesXb+zNQKg5DwVnNg6h.XW9fHhnti32uYfDQrX2t8WyfKyf90880hk8S6DvVnl8g5n.1B0DQDYThm9RPlPsAZlybliqolZJ8XcbDOPWWOQKg5DtV6MJUGFJ9O3PDQT2Q762LHhHJ61sWhmVEVoTQ8VHNTpSyN9R.ag5DtjSQBXLyVnlHhntcT8.FLjiVVxRVxo2XiMNXO+drn6VDJ0YTH95omPchXen1zwDpIhHp6H98aFjErfELkXcLD.GB.eA.1WzrR000Szt6GIbImhDvXNQ6jBhHhnfgomPsHhRoTIbewenvc283WGqpe61si7yOebgW3E9Eicrisjd0qdUwEewWbM.3vJkxoWwYZkUVYOcc0U2stvEtPTd4kaZwjllVh1c+HQrEpMTQiOmxDpIhHxPzcO4xdhdq25sFPiM1Xuh18a57yOeL0oN02+ltoa5O.fOUoTGc1yd1A78qTpiJhTD.FWs0V6fLyDpA6xGQCIbwLSnlHhHh7qO8S+zKEH50uoc3vAlyblSYicricRJkZGgx5pTJcQj6E.urIEd.HgrKeXz3n7gezS+jBhHhHJ.pnhJlXzptl1zll9S8TO03TJUEQPw7QFV.E.VrXgsPs4KgKlYB0DQD0cTqQg5PgDvu3OX4tOhO9nQ28XNyYNGYFyXFmkRo91Hrn1ugDPcBNNT288b9HAeJnIhHpaGIVNU50Mwa+1uc5.Pyr2UNoIMILiYLiyw.RlF.nYCnL5TZZZIZSq8IhITmv84WlPMQDQcGY5IVAWsPc2VM1XimlYWG4jSN3Iexm75UJ02XPEoyt9sDgUfSm8zu69IbI6FMvDpIhHp6HlPcD5K+xu7bM65XlybleZe5SedGytdLRZZZIZ4NwVnNJHQ6jBhHhntjRoNQznZhB0QLyAO3AuHyr7sa2Nl7jm7TLxgawnwP2H6C0QEIbwLSnlHhntiNdTnN5V+cnUUUUsKgZid1bunhJ5P.XSFZgFEnoo0SuKeP9Q25+w.hHh5w5nQg5na82gpTpKy6e26GNQiH457xKumLQbx.RoT8zagZ1kO7CdUVDQD0siHxghBUShVhUAMQDsrxJqd0I+8Hp7UJEF23F2aGQERrSO8bmR3R1MZna8UWSDQTOS555MEEpltyIVYqwFazzJbQDjYlYFRyDhAY4Z58qcQjDsbmRDS.NgKlSzNofHhHpKIhb3nP0zcNg5TLywe57yOe.fnwwHyP24i6TXhITSDQT2NVsZ07Zd0SJ4nPcDqjVTnNLiYyRSOuF1GpYen1e3UYQDQT2QGLJTGoZjE1zl1zVT0UW8MC3pKQDLO3e5555JkpE.zrHxQTJ0g.vADQZPSS6ab5z42poosS.T67l279JGNbTSvDKG7fGLEO+rIN0iaFcOCSOuFccc1XjTGvDpIhHpamq3JthnQB081nJHQDqicri8lKu7xC0UUCtZo7jAP5.XfA5M1PCMb..z2foPWyZVSaWrfI10ORF.GyfKyT552RjQoTIY10QbtDtVONZfWkEQDQc6XylsnQW9HKCrrNqpppJCr3bwmV4dMA65oooYns9tuN3AOH.fcSnnyr5pq1DJ1ShOThQEIbwbh1IEDQDQcoVZok.lPsQLFJuicrCzbyMepQbA411111tE2IYZX7sqZnqqupfccas0VsYnAiObewCmgITzCwn2O5G7t6Sc.SnlHhntcN2y8bC3HHgQzEFprxJQRIkz4DwEDb0hmevG7A+Finr7oba2uOtwMtOIDVWSuEBW6ZW6UYBE6kDFcalPhRo5omPcBWqGGMvDpIhHpamAO3AapyThUUUUX6ae6FUBgm6BW3BM0tXgaaHJTGAspqt5etQOtQWYkUNYir7BfDsDpSDS.NgKlYB0DQD0cTy4jSNlZEL6YO6KWDIhRDVDQs8su8EX1sppCGN..1av99sYylYLj10Nuwa7F8A.82nJOQjTpnhJt.ip75DIZITSQALgZhHh51QoT5CYHC4aLvxqCu1y8bOGprxJmaD1Jqi61tsa6Rhf0OnjQFYrFkREzIImQFYbDyLd..VxRVBZngFtCCrHup4Mu4YfEW.0SOg5DtVONZfITSDQT2RiXDi3s77yQ5ChXf5RwSYJS4mu28t2YDNIUKhL3hKt32yracZ.fQO5Q+zgx6ejibjF8vYmeMu4MuYGosxOfqV5eAKXAOcs0VqADUcIl6D0A7jBhHh5VZvCdvsMpVXVOicUUUU3Ztlq4IqrxJWhHRPOL5IhbESe5Su1YMqYEU9d3QNxQtxPbUL8VnF.3QezGEqcsq8OEokyANvA9gyd1ydPFQLED5o2B0DQDQFm7yOeAtt8ml0hgorxJyTiU26Khq7we7GedvbO9ztkIMoIIqYMq4UDQtLQD6hHV7zx0hHZhH8VD4RJojaYy4V...H.jDQAQkR9nryNaQoTQsXSDIjRBzcqFGUhMGNbHG3.GHuPI97IVyYRSZRQs8kkUVY6Hbi0.sIXVK4me9hQ+fe5db31rOe0LlEMM6yMHhHJbvDpa+WbajwqQPDIM3N9hlIulSN4HEVXgRwEWbaKOxi7HRd4kmX2t8nVb3YI2bycogw9Nsnv42dGixt28tcDFwYtEUTQNiVwI.jUtxUtqPMN6pMCyZgIT29P2jWHhHJbvDpa+WbajwqQofBJndX9eQZb8xblybFW3ruaLiYL6x2xxLuvjbxIGorxJ6NBlYhPQD6qcsq8u4vgin99yUtxUFziVJAISKVMoDpUlYL6pJR7Rnl8gZhHh51Ju7x6+IVGCwZiabi6SCm0aricrcnksMy46kZqsVL1wN1mIu7xaWye9y+Gsqcsq9KhXyc2kwpHRVaaaaazye9y+Muoa5lZXDiXD+byX5ZuqnTJl6D0Ari0SDQT2V2vMbCK9du268OGqiinIumxwyM2b+XGNbDVOfgCdvCtb.7yMvPqKoTJrpUsp9upUspWxyqke94iFZnATc0UGMCk.RDwTmV1oDS7prHhHpaqy9rO65yM2ba23QcjND5EOx6sIuaE465ttqGJbKyK9hu3OKxhJiQ4kWdPkLsRohVGaYiQRc.SnlHhntsTJkbW20ccmd+ZlY2VHVweaS1saG2wcbGeX3VlW3Edgesc616vqaVIs5cKqGNDQhJGaUJUBUB0t626ITRDiYlPMQDQcqcG2wc7VYlYlsMQkzcuEp83tu669QTJUyQPY17nG8nCq9ec3HPICGNGuL4iwrKePc.SnlHhnt0TJUqSe5S+1876whVn1rSh22sogNzgh65ttqHdBS4ltoa5w5p5xHzY6e7t9B18icGuKDwKRDa83nAlPMQDQc68HOxirnryN6C46q6uDzLijeM6D77s+C+POzCMkS8TO0Hd1Nb7ie7UDokQvHX2+vDko3ULgZhHh51SoTs9TO0S88b+ys859KAsDoj17rs3c+GNu7xq5oLkorPin76W+5WSie7i+cLhxhh9z000i0wPXHQLlYB0DQD0yPgEV3GVPAE79IRIL2U7caIyLyrkRKsz7TJkgkTxjm7j+uMpxhhtTJUKw5XHLjHFyLgZhHh5YPoTxRVxRJL6ry9XAw6MZDRFtm3Idhwblm4Y1nQVlEVXgqO6ry9qLxxzLEMN1YRyjelgVi0APXHQLlYB0DQD0ygRoN5hVzhtrt58kH1J1ScpScJ+W+W+WehQWtJkRt+6+9uEitbMK4latIrWPjQSDwrZsWyrUjYKTSDQDEu6RtjKopRKszepme2SxWIxIgMwINwG4O+m+yKvrJ+ewu3WrtbyM2+kYU9FkoN0otlBJnfDxKHxLnooYV8GYyrUjYenlHhHJQvTlxT9GkTRI+FfS1ZzIpIgkat496W3BW3rLy5PoTxK+xu7OAwwI6LlwLliLu4MuqLVGGwSz00MqDeMyDpYW9fHhHJQwsca21iWZokN8XcbDIt0a8V+MUUUUOTzXrA97Nuy6PEWbwi0rqmvgCGNvq+5u9ECflh0wRbFyJ4TyraYvDpIhHJwtqCzSyTlxTl27m+7KveSw1QhP8bfv4bla8Vu0a8EewW7wilSzFO5i9nqZ7ie7ORzntB18I1saGkTRI+x90u9sQSNjR3XhixGl4cpf8gZhHhh+65.Lg+161u8a+MV9xW9YMjgLjCZTkYndNPH99Owe8u9WuvW7Eew+dHUIFjktzkNquy2467WMy5PoTA09D61siUtxU9.iXDi3oMy3wORT9PD6xGQILgZhHpGl38D9iEF0nF01pqt5FPAETPow5XAn8y7gdeAP4late9pW8pGvcdm245igwl7EewWb24latyyrpCQjNbge9961saGkUVY+rQLhQ7G3zgc.wt7QTBSnlHhHB.Jkp4ktzkdaqXEqvQ1Ym82DgkUDstdOyGJh.61siG7AeveQUUU02cTiZTF53Lc3PoTRUUU0LJpnh9kAw6Mjd8.8979BAyM2bOxm9oe54O7gO7Wz23JnJzdNLqtlgoTttOVG29fu1YXB0DQTOPraeDXW4UdkUWas0N3RJojaIXlDX7mH4t.365NwINw24y9rOq+O1i8XOsQNCHFoTJkrvEtv+1K8Ruz4lYlYdf.89Bz9B+0Jz9a87c8m5Tm5arrksr9etm64toNI157fumiDpt7g6i0lZKTyyMHhn3L4me9B.ZawcqiYjKFlxJqLyJFE.Ht2WzsiHh0RJoje3vF1vZB9rMaV6KAfX2tcYZSaZUswMtwuSzZaMRHhX6tu66tXDjaegy9tryN6ld228cGSWMKEVbwEaHGaBTYTVYkIhHVhncXsmoc9Td4k2ZMv3zaeoQFm9rsaVwro84U2KDQDENxO+7M0jpLxXsrxJqsX0Lh4tqIT6gHh15V25F18bO2y7yImbLsi4ETPAGeAKXAyVDYHIPSu0so95queEWbw+MibeTt4laskVZoWevlDawEWrol3jYkPsYrL5QO5Oy.iSusdSLtMqX1TOuvjhYhHhntmDQz11111.JszRu964dtm+u7xKusiv3Kfsa2tjWd48kEWbw+OkWd4WuHx.DQ5VzULEQR4y+7O+xKt3hmSd4k2gQ.1G3uKtKyLyzY94m+a+3O9iWPc0UWVIhWXA0yCOIkHhHJBIhnsm8rmz9jO4S5UJojRZG9vGNiUu5Umg6+rtHh90bMWSyNc5rgicri0zMdi23w.vwhm5SzlE2IDmxF1vFxbe6aem5INwINk5qu9jqs1ZSQoTpgMrgsud26de.cc8CdsW60tG3Z+BawOhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHhHJnoh0A.QTzgHh5a+1uMszSO8LrdL8LaY+6MoV14NkiH331uzQ1Tu6cuOD.NtRozi0wJQDQThDlPMQcisqcsqdYu9CdE6YU+6a6a27Wcye8V1J1YsaAVDAV.f.cn.fnzPKPg9zuAhS6LOqO+rFwv+68YTe2UturyXKCcnC83w5sChHhn3YLgZh5F5n0efgr8WewO9m+Vu8srmstYjtnidq.RWSCIqofEk.E.zTJHPfH.5PCGSWGGWDbHcAMJ.oLvSCW4O5G94478twecpC8T9.150DQDQcDSnlntQ185Weu2+qs7RW0q7OuY0wZBoYQgdYwBroTvJzgE.nAEf6Dp8l..QTPGBZAZnYQvQcpii3TGRpYf7u4e3VFxO4luxzN6SemwfMMhHhn3VLgZh5l3PKaUW4KNqY8dXueq1.rpgLrZAPzcm7r39c44i7h6eyUKT6eJ2IXqvQZUG6woNbNfSE25COyueFW2necyd6gHhHJQASnlnDbhHpM8nO0ua4OeIOfcK.YYyJRF5vRae5NPILGjkOTPW.ZFZnwVZE6wIvUM4a6Q+NOzzeTkREYENQDQT2.Vi0A.QT3SDQ68l18+7a6sdqe5PRRCooAXQoC.AZ.H76vydVSM.QGVTJjJzQJ1rfzrHnrETRw68a2cFhH2GSplHhnd5XB0DkfRDQspe4uYga+8W1O8TSxBRSIPSA3oEo8WxzZt+ud9aApKeHtemJ.nTmrahnT.8RCXHIaCe467ulAtazpHxugIUSDQTOYLgZhRP8dS629Pa689W25PRNIjrOISGrBb+mNvqgEkB8F5XP1rfM71u4uN0ecu2H.dtPrfn3TGn5MJu1eXNHiV0ce9gNf399cz9tfuWcZPMzjMK3Gb+2K5StmO6JgDQ83XcAKXARs0VarNNHxzje94iwN1w1s5K428y9xW9+7OL6Yc5IYEIqzglRgfIYZ8N7SZ988o5vO4cY6pkpSSC3zSxB9zE+RK3q+GKo5S+mTXkg1VAEORe+MfCr5OCopoAEb08gbcdfDvGsU.MzftNz2eCQ83kHhhGXcgKbgn7xKOVGGDQAo5W8pS60J5tWwoZUC8VCPSIveISKh3U20n8TtSIJ76mFBrn.xvhFFftFd4+ve3eW+pWc+NsQMpiF1EIEWHIccjttSLvjz757G2muHdFxE876mb8Z53NQR5bXJmHpmI+27TDQwkDQTqegK5krchCmbFVs3tad3eAJYZ..Mn0VRQ.tGCpa2e2y+3f.Q5rjjzQlVsf9brij51m+hdEQjtU2IfdhzUZvUqQ64rhStnZaHXz0hlBPYPilLDQThLsN6KcIhhubzuXainp2dYi2tUMXQo65QJTB8DYj1tM9duzIu+NoNrAcbJV0vZd+kc8Ga8e0kExACEWwy2Iz9yHD+7eaeR2gd+wmHh59PKb9xXhRTzc5BFEQzp9u9zKt+PG8RCsMYs3uAXi.84ZWsunqIqEcuSlVb8e8jdjN7Zj.Q44166+xTo.R0hFRWoiU8LO2qKhv67UBLktS+8pv6yONIwq2Q2mOqQDQgJ9EeT2ZcmtfwV149F4m79u8f6iUqvVaup+6NF9dgDBTnUQgCqCr2Vbh5OgST2IZAa+3sfZOQK3aZtUr+V0wwEKPflqDu8ZemRo5XYJt5KsJ2ofmtUaXMKaY8+Xas9Kw31pIhHhh+wgMOJnnTpPJ4zP88Scsud4kMqTDcjllMnPqte0t9ZhE2Sg3M1hSramBRZ.CBCKuQqaIyzK67bLhisisr0w9sady8Z8qZUn2GoIzWqVPurnfl69RafnTmbLrVAfT0zfczLNZE+6hAv0FwavTbj.cGOHhHBvmDp6pasK0yUvdNgmDoC02uYp6v4yhHZKYJS8ZSSS4pyZnT9LPlEXsH.6u4VvQSNcLwe6CsuT+OG20ZqeoUoRozcW1pb1+9Gzk0vTels9zkd8qZwuLFfnPlVs.k5jcsjthU3D10Tn5xq3+TDwhRo7WeGfHhHpaGqdmrQ2gDOnXqP8bHOueGNb.61saFgDF5PGpoTtQS6bm6L4st1UiAawh69Lcv8HfIPgFa0IZH0LwT9q+e+6ZxJow8cNkd0r2uG2yxg0KhbCm2CNiauuWv47LKY1yBIqIHEMOihCttXaMelEFk19KBrBExvhF1VUqAWzgNTe.vdMfMcJJSuyF4Xb+e8+3QMQD0yk0JpnB9jjDmHBFxw5p0y2+txO+bm8e8cwynplme1J.r.fyXFyXFq5odpmJ3BZ2sN8Dm3DOxBW3BuXkRswfZECQcGFm0ynIjp9QNBRxVvMAt.3JYZm5JzXqBlvuY5eSZWwvG62QoZIPue2IV+rsdvikxn2vl+ye9heYLvjsgj8yzAi+no.RRAzxwNLrrwZGBXB0DQD0CA6C0wQT9a3ZH3DyafHQjTKpnhdkW3EdA.D7cki4Lm47wyXFy3pUJ0QL6XLQlysrwdkjtNrfNueMeRJnK.GUGHsS4TwobiW2OQ0IIS6MKYlxe4b9429srx2aYWduOwgQRV8dZfoiyQddHh.KJMXQDzT8e8YCf0DraeT7Csf3zqNbE5J9DtSD0yF+2.oH1F23FOmbyM2u44e9m+R8L670UISa2tc7pu5qNyYLiYbELY5tlruF5cRJw8CJXvMDk4DZ3HNchyY3i.624QVcvVWJkRb1mj9wWzMbC3vNc5dH0ycbzIi2vddFLRxhB0skMetAa8QDQDkniITSgMQDsRKsze0kcYW1Wst0sN6d85c55kat41R4kW9286+8+9y1yCFG041+Wu2zSVYoc8CGsNMoZANAPS5BN6QNJLvANvPZJAOs912cdA4cEe9w0ae6g6pO+3YTp9jG578XtEmZmcnTeThMQ57tCDQD0cG6xGTXo95queEVXgKeoKco4FJq23G+32v7l27thgNzgdPyJ15NRPq8VSIgzU.qCAMqTv5.G3FBmtSTZiZjOhnTuktHdMEm6JsIQ7dJm1SqSK.tGUPNwgZ57C05iHhHJQESnlBIhHppqt5a4BtfK3kN3A6XNwcV283Iexmbd268du2GGN0BC5VRuc+p61MVqse2WJ3T.ZUoAq1yHrdXOOlM8OWusCkdl+D07528eKjaUogZ2xVFb3TmT7FeOt6hF79bNOmGv1nlHpmK1kOnflHR5KXAKnLGNb32joc+d5vq4vgCr5Uu5q89tu6a5LY5vilEm8NTWGA.NAfky3L2Y3TmadyatcGj8tea2YSo6JnfEAoGv2.0sRvM.NRDQcuYc5Se5RUUUUrNNnD.iabiCkUVYgzjwRQEUTc+w+3e7RF3.G3t6p26t10tx49u+6ec0UWcFZxXEUTQXxSdxIzCOjNEM+tOw21Dz6wGXc.zJDn.1W3Tmibjir0OtseS4UYexYHQOWQtS2OLpthAABDafRHIZJWiIlJWC8h9q25684cmbfbzynoIQD0yi0pppptEiSuTzQvlLsc61wBVvB96EVXgSNXFt1V8pWcgW20ccKtpppxvm8DyKu7LrxJVwpfdENqmN.fldSgy5pTJ4+8Lt...Hhps9LsmALOQDn69E0TZtRxVTPAMnorvLqRPYsEcXILt7SK.vRqraePD0yD6C0THIXRz0gCG30e8W+GMzgNzE0UOLbhHZKYIK4OcUW0UMCOciDO0gQjXcm00DRj3DHn5xG9aqUzTgUB0.mrEJAb8fH5as440Ze6UqftHlRlUhHpCdvClYRUWyY2ZSG9+3.a9qtvSbjCM.EzrCfC0Jj8L3y5L+JjQZaT6R9tasWmRu1ShX2LRDIkiTwmedsV+tu75251tHMAmsBpVcpIe8PbLr+sZPC7i60HOuMpTpia308IzgU2G9B1O8nT.IqDHsD+mPsHh1Q1yd5Op+PiP9l5u7iU+2LhC7s6dnG2hVlIMzSOqy+mNgThz5nlZpIkrVWsmNN5gNic8U0btZJ4zDf9XQzaoYkZ+m9vGYMJ6otYs+ir2duNkSIg7bThn1iITSQDeS5cZSaZG3odpmZDJkpttZcEQR6ge3Gt7e2u62cQA3uafQZhMMsfKgZ+RWNQ3tp62hErsSzBDn6yXesmDm7sgnU3PZVPV1rDtUYGHhnNVM6ZHacYu6DW5jumea0e3pRMUAHEQGIq4pkQ0TJnKBbBMzrtSbBkBm.ZXPm84fJ9sy5ctna759codoi5SL5DWd6G8wk8tgMAq5.ZhNfx8iqm35+pCQWAbBHnQ.rakl1lOjErp9l647RS3Adf86614g+vpN+O3UVzS9mbbY+mxgODRUDjjlx8D5iNZEBZ94vO9XZVPZC3Tw5+eK4edVEdMObJCdvaITi8EO6+zf2+52vamVqNOOMnzzT.V0AV97lKR18zaevLIBob2cfRB.K+olCd8ITjzpFfd6lGfzvQroggeSeOLhaYBALO8iT4Fjm6IlCRuEfjz0A7LpZ5ybcttt68qJz3IzT67nZV9ve1ucp+Oo6vwdBTYe3ce3Ad3O7Cti2ap+1e61VyZR8P6Y2HIccjrBHIkFZBZHyQMxtb6MPNz+tp9u525eM9ZVSkOz+3pJH6jgNRVDXSSCVgqtQCTBZUDb7EVBNtRCGSA33JxCq6uT5+5r9dW+uO0bFvmwjqIJwjU.iok.odl7LQtjQFYf4Lm4rroLkoLAkR0kIvcvCdvynvBKrpktzkZpO7ZcWNuVAIsvY8z.flRZNbq267Y+aHMmNC58ihlBmPofkrri+q+YIga05prDQcz+8ZG4G8K+ue9O88V140aEPJVT3bsnPRZZvpxh6d2qt6zMc0Z55BftxBZUzww29WhMu0MdsU+OWz0dFemQbfFdg276a+VugJhfYkz14PewFvgqZsn2tSrWb2ihUt+uhqCAop.REPMPAH2iIpa9fh52CfLZa6bsaaju2O6Ne4u5iV0Y1aMAC1hUjTRVfMkx8398IuvEcnPqBvQ2a83idp4bKevS+L2xWL6m5US9Vt9a8bNmyInu3oC7EewSbzJq5BRQ4pWu6D.5JErBAYZM3ufHA5.PgzsBbhctMzxW6ZV5z0eCvUJ2ZnQcfiMBGcdgsmCf8+YeNRxhFrH5s0W8a+7yIfx0D5XpBPpMqzF39bJWj5aa55Av+guE4w21WeN07BuZouvUd0Wt9QaD81hF5ilFFnMErpr.k6+mkV0gU8PqE1EQT6Z9+iQTwK+JO8yMwe7HSSoPxZZ3broAaZ1fE2mQ.34HnNzgEH.nUQPKBPSeT43iW0JtgULm4bCWz0bsG4nqdKSN0QdVuFGi9IJwhUftOIcPwFYmc13Ue0W8tG4HG4eMXRTolZpYB4kWduV0UWczH75lPEVITC..MsvNg5Aj+kFS5yLMUe886ct66+est2dYWx.z.N6jrfT0T.p15A2v+sdpS2Ye49+poAcwBZVTnwMs197bEu1xF3hekOtgxJ65yZriMhGKzSuEcnoogLrpfE24+HtSPCvUeOGJwqeGP0p.aNQ56d26t2YYMkKbeu5auv+9rl8Ym4wNDNijsgTTBTs0Bwdxoxo602UxqJMMjgxBDq.M17QP4K3Y+A8up0dYM90e8vx7zO88ifPuZUtrjUBFnUe5e7BfRE527xzrZCo59m85BJf39pJZtYmH4tnsWkVDjttNFPRVPuZ6ghzqxqc6Oc86GFZ3HszBjVj1MYBs6cu6du+E8V+s+5Mcy+zdc3lv.sZAokrMXUyyVp2mCogjfNrDBIT2vG+w4rf+yu++5va8qtf9aUCmUR1fUkBJkmn1oqK2Sz8oqm4DZPAcO6y0z.rZAGSWGad4uSu9v2+cVzk8C+Qa6X0TyUk5PGZsAc.QDESwt7QBj3w6jvvF1vN169tu6Ecpm5otgt58JhXYEqXEyc3Ce32SfF187HdbaMVRWEAOThhjPcKja5MK+ld9q8G75ocrCgyJIMjhlBIA3URl9piiSxdnfBZJAIqDjkMMjpUEN35VykN+aaMMrqm8kF6odG+3xi7Ht8ImcxQ8BwchpsetlTSIvpnirNQpG5XKdY3Ee7eGNEq.8IIqvFzAf.KtGIU7M8Nk5jiC3dt10zspAqV.1S0qdPu4jtmc1zl+lry3bFzd65nV0+N7Jd1.B4gBu12RxdWdd9rrDDWZlHhNThFbuenCkW6hMW+tlm96s6cNhHpi8gU8CV5s9KWTCa6qvfrZA8NEaHInCM0IW2vkHh1Fm0S8HK7VuiGNSkNxNYqHEEb0tyJuGObbOZsq7dDxwEcudOtNNpPJZJLfjrfz0E7kK5kNysTV40bnOXs+zdeEC+kLp6nBQj4gOI9IPh2RvbhSbheb0UW8oDjIS2q4N249oW0UcUcYxzte+FRL1sgHo10uI+qUQZ0HCEyhHh5qe1E8X++lwTe89d7CgAmjEjolfTTBzTtRvpi57VTTCh6EfjTBxPSvfRxFFpUK3U+COVYuy87.SWjfIUuNIt8YVjz8q5m+q.nDXEJjtSAG6MdS7xO9rwoaUgSwpFRVIPSItGt5Bty+UPGVTB5slfAkTR3D0tkTWxccOaau6cucYWoRoPxdhoHIAS+yS4o6yO2kZ4jqeWs+z0+UAWcSEzRqXW6ZW8ZGK7Ud6Ebm24hZoluBCIYaneVUHUkq8SA9NaDbpolZR4cm58+QUrv4+vYaUgSKIqnWZ.VcebSAID+2tzgm8QZJcjrRfcMfbR1BRd+6BkdW20eutm6U9cQ54nDQlOqyctyEASBNTzk+Zg1pppJbu268FxIaN8oOcTPAEDVs5q303KrOlY94m+iEL8yucu6celSZRSp5EtvEFRsxZgEVHl1zlVnrJcfRoP1YmMdzG8QinxIVyUevML0wF5LtiHh5aJ8Ud7W8+YV+pyvpFxzpq1nUyqw7ZucxYHx.0l.tVGOMMuVakh.KJcjgU.MMqX6u0Rm6GzrdeEQlYj2JfZcnkH82CuYxPG56bGX4+0mBmhUE5kUk6goN8NrVss0zVqv561qqdtM.PRPGmhUK3q29Wk9Nel+dEhHiJ12Ob0PvOVg..HsBfjgqAewN4D2Ste0BzQJJAxwbh88vOw9WUYuax80hFxLIavJz8ycIH7Te80m1Wb+O15q6iV0PGTRVQZZBz7sEoEAvO+6kAZOfVa8rZOEfqtGhBJzWaVfkieX75+tY8.+.MXQD42xVpln3WVG9vGdbyU91C3pvC2suTprxJW9i9nO5kFJIDa2tcL+4O++32+6+8efXwWrJhnpolZ9AWy0bMKZcqacc4626D9exm7IOz8du268Af2G.6A.m.t+dmdjeohD98gZKlzPXmQ5.KZY+7W7wl8u5LsYA1s3cejt8ejQEfDr6JhHtFIPfqx1hRgz0DXKIKX8u+a9Po8GFTq.HLtpqP7izh.qPGGoouEV0rfzrZEZ9jLc3PA.KJfzz.5mUM7tkL+getW20OA.7pgV3EvKfNJoqGy58kF.RABdue2Cfla9HIOXqVQpVTcxc0ve572mHh02ap+1OqtOphgd5IYCIoD2G25Xxzd5e2giStuWPRJW24B.crz+zb+MS5LO60CfWLrJXhHSWbUentGPhRg71mHRuKqrx9rILgIbdgxcRvgCGX9ye9W6nF0nd2PsNMBhHVJqrxdpILgIb2AabKh.61siUtxUNygO7g+GTJUBQWUHZPTpjB6U1Z7cKTe7Mtwyoja419+ksUfzsz99IafRdVOfCae9mnT9TRtpmTzTn+1rhUUxy7HM9lkWYl2X9uQXtY.f.2xztGL8fRoflBvBzQpVSps9Etuy3jmrEocWtcnko8TedRZTqssodaQCCzoNp7Yl++PDYoAyDqTakWWjL8Iuy.ctf884Gs8Y9Nac8ztBJkNrprhzTBPyGA1sYEVUmr+166cLv+2Agt9bncO+Wtju7sdiKXvIYEIqcx9Lu2Wfmm8cJuJ+NtM35U7skoaW4z1O6ZwtUEbdrCgE8q90uvwpolOjOnhDEeh8g53XhHmVwEW7NG23FWHkLcAETv96GdEO...B.IQTPTcV5RW5oECSlt2yYNy4yG23FWPmLMfqYzvu5q9pKeDiXDylIS2dJHg+jMQ3zjtQIhHVd0Y93kk1wZD80pl6t9f34u0w2uAtonfq9rb5VDLPMfE+6erkd38rmS0vp.e34er0lEqnWImhqV3zmadPn15vcb+g.aPG8wpUrwOrBaGaG64RB35JxwbMpd3cJfcNO832f88FFBoO26Z.4SPxJExLojPRZvU+P2.OOo4cr2KZwy6OOwAY0B5slqKhQ0IWvWXcGTZ2Cx3I6G1JEfMEP+SxJbt2cgO+YdoxEQLtA4chHCCSnNN01111tXGNb70yZVyxdnrdycty8cVxRVxPxN6r+FyJ15L6bm67rmzjlz2de228M7PI4foN0odvxKu7Se.CX.ejIFdIvjvuEp8ybbX7hCurJtk8T4pGjca17Z3Fy8+emd9iFBm+4qN9Ho4p6ejkMq3X64avWM++w6KhDl+6hdGusO9NYhndZYSw8XDtlO+c2kjRycqR2Uamc7uqT.opAz5QOD10JJ+GFvUUvdZ+j0ixcj4IAaUmT6cHha25q6UYDhO0FcQqo6pd8r+Qb2ZtoljMnZWW7vUp19doBmLp7z0L57C0hHZk8DO4Rrd7FQFVUt6lGmrF57nzebsG0ye2yCMqukm2m6qb+.K1WaVvmtnWN6C+gU886zflHJlfITGmQDQ8rO6yVzHG4H+TOiSyJkpsk.wcWk32L8oO8qOXlXULZhHpsu8seK23Mdia1yCeXW0euUJEra2NJojR1z7l27FrRopOpDrIjzB+DpEqwkc4CQDKq3YK4Y5mBtF6k63euCqSmkDSPTe980UPG1T5HKKJTwK+OufSrsccsgckzI7M1E2+Oiud.rnDjllBaoxJCXxWG2h1GcXkFZPG3.NAZPWglzU3v5.sn6+3JPiQFhHnUA3v5.GTWgFzU3.NANfSEZvoBMHZ3PhEbhttW8ExsPcfhrNaeq.A5xI6vEApE5O5110HVya+VCxtUqvRGFR7L1iccV4offzz.FfxI9z+1y77hHwUcWShn3r9PcOchHZSbhS7O9BuvK7q7406z0K2byUeEqXEWd+5W+9DSM.8g6GhTM.XqrxJatSXBS3W3aW7nyFYQxLyLwJW4J+3gO7geU.33taYvP9ao5Az26AzEaQvZGWt+4narlQUy5VSuN2js4ZXOymvzeW.YfS5v2dIqedGcxEjpffdY0JR4HMhc+Fu0BDQFXnedUW7fsEDGFN4LsHPv1+dA7+CSXxVzvt17VGjHhl+dnj2uE7a1qScG6QzOWKJklBtF+q6s3D8Csh9kRpt6q5mbHr6j0f2wkqDROXym.6VWCGSyJbBWS5J5tqVMQgCpYEmexcwowRW0UuZ+9i.uOsq1Wq763Csu12ReqGLKQGopYCJ3+gy81+fx199N+I+a9+7S8P3BDsBf9XyFV+mrpju70+kWA.JOnWYhHSm0JqrRITRBhLOSdxSFuvK7Bgz5TTQEUyy8bO2nTJ0AB05yqDhs..a.HI.jB.5E.xXqacqYVe80mktt9onTp9KhLH.b5.Ha.bFkWd48Bv0v42LlwLBTcDv5O+7yGKcoK8RW5RW5Q72eu1ZqE0UWcc41Q94mem92m3DmHlxTlRh8HHiV2uVjZ6qrr6KCMMjjxuizXcJAtldqaF.sHhqa8uHvlRAaJWIe36nvPWIIni9YwB9r2ZY8uO+jar+.X2gVTE57zEINgnPKhSzp3Zl1yF.RRYocaGc1HvQ6ecw8GpU3q21lwF1vFrBW6pZme0+741I.N+1EOhX6HKdEM+Z+56wc8E7aKGWTXJ+o+L58Dtp.tVOwL9kcdgnBsVntq3ZavUmpPW.bpTnUQgVEwqgTQ.aJMzL.RV0t00xht5ITXVVzbOg63IDa+HMSGSp2c23Qbsw3DVbeNpqKbylRAateWdN15cYFniyZJWilIoqD7Iuzq8.fITSTbEq268dunrxJKVGGTHxtc6XtyctuzjlzjlXv7.7cnCcnK7xtrK6N+hu3KZKgXkREVy9dFkkrjkfkrjkX50Sd4kmoWGlMEhfQ4i3vGJQQDK+yadJ2bRZmbpk16v7jiRDcbz7vSxzG1ofusEm3nJMzh3DVTZnWvIRWAjkUWSU49NFD68nOguItXQAjtEE1ZMaFV18QNGDAITGnQ4hS95tZcTm5JzXqNw9bJ3nJEZVoCKPPZ5BRWSPesZsssiPI4Vc.XUSgjbJnu8su1feRnN.DUpIgl6PKmF3YhRWcZFAMCEToEAc0e.HgXW9vq0yc73CkFDQAmhfipKnAmshinqvw.ft69utEHHMQGmPyB5qWilJ6aeeYZ6plsfyxlEuFgwCvChXaCYdZt+cMzh.rulaAGVT3HJEzUZvhHHMwI5qUMzaKZHYnBvD4S6Ou2yi.IT.IqogMT9Gb0hHV4CuMQwOrxVhNwS1YmMd0W8Uu8QMpQUZWcaoEQTqYMq4NG7fG7eIda59l2Ijfm35NHzsQi6nwL1bUUh+CqZ.p.2Wh8cdxPfBGwof80RqHo9MH7Sm7s8zVu3QTxgOsr1jkFaTK4MtqeyFe6+0Crl2eYneV0PlVUvpx+iKvmbXNyUx7J.jjlqYUus9gqxA.9ffc6Ifc7f1FsFTs86hRAQT3n5.6skVQR88TwOYJ2wAS5hxc1Zm5otIkneZmXsUM8M8uV1ET46uLzWqJjgUs.tcDHJHvhniTWyVSB.98t.4ONsoPKAY038P8VKBfSqQ1MBRElIT2V73YXGDJ3T.NpnvgZ0INjSmH8SYPXjiIebFi9J1j0SaPup1fFvWHh5H56Z28o0Msog8wexm9C27A2a1sUXUt+zSRzQJZVQm8OypfBhxyEWHnUQglZ0INPq53buz7wH9dW6VrNxQ7XV6cpaskccfS4Xq4y9cq9sdmKnt0uFLvjsgzfpc2MEUWbbNMKVP86YW3He1F5G.91HY+EQjwoC2FYljS7sBJnfi8BuvKLpLxHiM1UuWQDakVZou7sca21DBlxNZeb265im20k5d8.Duys1mTD8Njjnusrq2i+xBTvotB6qEmHmqa73xm48cNoz+9uEeJ4G7nG3nO84eC2vm97Ov8OPUyGAYY4jsTs+awaoc+jMMMr4Oe0iJT2j7tmx5gu25dQcxQBi82Zq3Ltta.WQwy7Qs1uzlkO8y44e780z4eFWznJ6E9Cyt+CA.1s1wVbuyhFkRCVD.Km3ngxEi4tviYOGqgUB0J.2SdOdlcE0Pis5DeiSmXPCeTXB29sUSxW5HtaqYzqxTJ0wBPw7eKhX8ddwmE..a8S97LSVC3j8eb2WTjed3GO4eSginC70sB7ydfhQl2z265s1md8Nd2vGhHK8p9A2zOnrYNqEs829MvombRtl1484tz3985pt8ZBewpRgzzchV2ZsmFXB0DE2nCeIMSpI90C+vOb0KYIKY.AYxz8eRSZRaKXSlNVim204jHJg53uctp8erSIUHnqZPSuGYLzEfC4Tf09dpHuY9P+P+jLM..RqOosilFwYclW8TlxgNXqshVE+292AZDCwpRCM8se6EEzaLgHcAnoVchj5yohK69tum1Z+R6Q82CMXJ8KiMpei4elWSQ2tdiNc1V2DIX+rhF.fRvIRxRHmPcv1Kg7NVLndVTX2B0J2yDlsH.65DsfClTZXJ+t+XK2ze6ubMOwGuhyxVl8dYcRxzdJi1p+F16txzpRqs6Phtn2EibH.hnvAaoEbE27OFYNgaX715aueaeuKhJkRr12zdk7djG7ty96LJbvVZANE+u+yeitSVgfdYQCe6117Y1k6THhhZ5d0pWcSY2tc7Zu1q8Wl0rl0HU++Yuy63jppy++edN26Ly1K.KsUDVoXOrTTiQklIQ+ZhZvRrjDAiIwDiQCl32zCfl52eIhDIwBJpDMErhJZrQWMpTUPgEQDQAVpauMy8776OtyryclcJ2orM34MuF1cuysbN264dueNOmmyyCQ0mr0eqacqSXLiYLU+vO7COjthxW5P2a5Mt2GpivtWc2a3sKyGAnZefxCGKIbprzYttqMnv9BD.W308Ma1nrBdxDs+Ku7xaphq4ptBN2BQaZmcoHbjU14j.yIlJBe71p53S05jyVzwKNDyLi1.vAszXJW4U.uCqrYjH21Z.CX.Mb7W+086rxs.zjkFLGo.K2DMtMB3OkbWHMEZOmbhLdImEtmNoQ4iHwY8mCFWoOPaAv9yqH70tm6Y8EdkeoR8zuBe4YO6Ymxlb+.eR0knbFIPR3yrrWK+ZMZFJbJe8qbqlkl2ykn8um9Uvc+49pWd8GRCzJGduvcnlEIF.HWB3S1x1FlqqLBBBc5Dy6XEwN8bnxJqDqe8q+RtzK8R+ADQwNtMEDlY0RW5Rm4YbFmwJ1vF1PWUQLsvMVYSZGdjKdz59FJRG3FXlgeFnQRgbF23t8jcu..fYex+0F0nGGZl0AcGiXK9K51YFDAuDTtKAuDxGhcWcfHB9YFM.BEMtw9ZIyho..bNpkT4YdNnQsF5zvJvjuBSkLqGCjdhiyFVnlSin7QHkxZF3v9sPy4THt9+57VUdmUkmNQjq8c7nIGfRb5XPIsbv.sxDF7PGELO1AjvNJA.PDo8M4ydF0qTveBddXzWKHX6qls1P8GSRKTBBBcYDyWXHC+tMc2B5tlq4Zp4EdgWnhJpnhmJYqKybN24cdmux4dtm6rRkz8cOYxVsCORn8LaaXpiXfznOFn8bhXBRsFAWehfeVil.fQ486Yb4gowgLxQhV01gHs1yNgHr3unsCn85ngIygB2bYDcXdB.6v1VKjBdF4ndQ2rO7ahcUxPFBZhA7G0iriqkvcrbpsVSo5gJMucIqXgZhSIKI6LX10nFXuAz3K9M+V07oCnvuPlFAL176t9R7Xj7PienqwV.nIsFCdji.MS521MGCqb88xiZziAswg6xWGRvQNZ2FBBD.QCzkUEAAgt.NhK11lMwMBwprxJwEewWL.regokkkNneu4zBZZm+Tq05n+tnW+Jqrx2dpScpS0MVvp5pqd3Se5S+sd3G9g6SRKvAo3hKF27Meyc6cZnqfIMoIga61tst6hgfCd22cCk3IE8iEKViStxwh5L22G6xMQqIf.jJkrcphTvDVnr2687B2Gt4hIw59q.LiR5+fAap1pa1GM2by0O3wLFz1Cmd1.lLM503tPjlSCQv1QMkFrrPQiXTn7uwUNUOkUXFmsX8n4hINzjML9c3q8H3B.7yD52fGLppppp0MGibKM28FfHn4D+b3X0KCEyt948BBBc9Xt7ku7i7UT4Bd3G9gO1oMsosd.35GRcQWzEsq69tu6wVd4kefNwhVbIX5995Nuy67lezt3QhhZFUVYk3wdrG6JFwHFwiczPVFb1yd1c2EAgnvjohrivGgxDeIG6DkAg90uSnI2r9DQ71l8bBu8Q9sAWFG0RsijvDC3KuAkECUgAeLKSvh0neCdffPf83lsru8sus1HA3OXTfHx3mcGiZIgNZgVBwrqGcChHttWw0QKPGam8wSmwuMgSpq7zgs.1mEZzRi+mq9pgY+J30yzRQv8bQ1+z1K+Sjn5nKKiabiyscLHsshNCTR5tsBBBYe50X4hNS95e8u9ENsoMscRD4Zwz+5e8u9oW7hW7v6FESmyS8TO0yMtwMtNHlN32GSqiMsoMsFewW7EGwHG4HWzQChoORABwIuG2KECMUHwty2isgb9iNsX5lSa.aXYlYYoj3hBZVA1fNrK2.KfvSrxTdTkzV8hdNuJ08gZlQKVLLxqHL3K7B1IQTFMpBgfAUTJuMj8G29r0NFcWh801vSVwHVyTt7IHHz4QunGzl8gYVcpm5o9mejG4Qdlf+cR2lRJoD7JuxqLiYO6YeIDQ96zKjw.l4wLqYMqCbIWxkbAIxeoit9bG2wc71OzC8PCX.CX.auytLJjcQmQhH644WOrFtJKcFK+xMS5HXXgI1+VhtmuMcsYEA01GiNdbzJyFb4tHi5.QfTTPMqiueLG6ZhsXeMRe+utcRC+d1N1OqwHG8XALMdoLrDDtn.cIg+8D24u1izHcRyWiX6a0HmNkClffPZwQs9P8ZVyZxqzRKco0TSMmga2lQO5Qqexm7I+rCe3C2US3jrMLydOzgNzedpScp2XpjxtKojRvC9fO3b9JekuxONVw6Vgd9PciYZiNETbttY05ryZ5IxZuFdx2Et7Qx6qhyjxgy02ps5ZI46+faniCSzoo8jW.7kZcnxNyb6pN7j0gRcW9vB.Mw.C93OdP.aNqUVXUdtdUY6DoSW5bRgfqtGRPPnqgiJsP88du26vG+3G+dSEwzSaZSaGqXEqnrtCwzLyDy7Yt90u9CLkoLkTRLckUVId0W8Uu3oN0odKhX5d0bD10NxWWygIx3fAAMHWdpjHNsM3PGsjqNxrdGADvmOWMw4h1h7g7iZ68WxiD0DqSsmyyHtSD5jYo1LElSceJ1BJzLCL3wNFvlFtcBqlbHTnaWUt6HSuxG8ZPLAgdhbTkfZlY5lu4a9xu9q+5+..2+vx63NtiG6gdnG53KojRNTmXwKlvLWN.d0Eu3E+5SYJSovMtwM55s8htnKplktzkNrwMtw41vLlPOVRsvIVOdXNkcmBCPvWfT6zPNA.LShuZGG2JATq5rZnJzVHMCN3kR+98mJhGiv8xhUFzKd3wSpM2JIJ9Bp6BHMlTh1wnbP.rEmMeFcAoxJS.vj0H2TsMpECizoaJ7QVgRSAgd6bTSObYlMlvDlveYUqZU2Phh.FNIn+ReCiabi6dxlSfOliHFIEZB4aB.O.Hu5pqtheq25sNNSSyaYEqXEegksrk45HUQn51jlzjvsbK2RIabia7iV1xVV1pn2qjgMrggJpnhdb9QbpA0JRgNA1KfT5YOLyvGwvWM0hFdhWggGS6HyMCzA6BD5Js+.X2KdIvKYmrVrW4NZCgHieCgydhjQ5Gt45Xisn1ULP+5W+RAA0b8HEh.QYHYkI0W5.gzIr4EFVw0ksJKLfqc4CffIDHPn4csazvSsbl7Y.VygBRHcrQgkFvOiUdWyEL4lXHBf8nsXqilI2j3gDDD5pvDtMlU0KGmVywMhoG8nGs+W9ke4yn+8u+qOYqKyLsicriK6RtjKYQtICEFskkbq.e2Pn8yxW9xwjlzjxJ6yd6LyYNyt6hP1fzWnQVIiaz8BQ.d.iCrqpvibq+.3GJDvYsJTeTC0uWlfOvn.RiBTDHNkBoH1zYDcL3PpqrOBtdyzTZKn1OEHkp4Lfa8s6NCxnnYCa0hqBohtABv0ihBA61XdIM9uq74QCq3+fVAEQ6Q6UL7eaB.ufQNjF80LTZN5nhWGKHbDIG0Xg5jgSQsSaZSaaOzC8PmNQTRS4fLyFu5q9p28kcYW12tlZpIsDGejPl7SnSmLIhxzCWPsaDRvHGSEFfgWXAa+lMYSLOBD7BscbkNICvTnT+RWre0jBGNN8E4ZkZBpAntQA0odXyyIZOdxlkcWGEMXX2ouB83A4CFk5x1mD.LfFdnXG+TB0iNcGVB.ARrPsfPOHDA0AgYFkTRI3O8m9SOx0ccW205lzVKybIyYNy40uka4VNQm6GAgrMblLL78.sPMkhoXZ.6zBt2f0DMrharV2M3psUkpBQS8hQJrtYMKulbzceBp0VYjEp0Zc1zcURonnAA.hzA8eOqTLZrzwDzCApCIdHAAgdtbTuf5PuTcnCcn3wdrG6aM9wO9E3F+ktlZpYbScpS8MV7hWbVLap4dRjkvC8cYSWIQnamLxxc8rIVsQoX9cNUgGKAwgV6DoDlYNnOUG68qMJPpN8XfVpbyY5Kxk7lZ0CR0sInlUpLRPc94meVK2.vbpLo863kR2HlNrEnUQ82Ie6YwB0BB8n3ndA0LyXhSbhs9TO0ScZ8oO84ccw5SqacqaFidzi9OuyctythhX7JGI86DwzG4.kIC4O5Ilo7R8D3APpGClcZIZBDzr10V01efTL9Mm5jJ2f10MQA05tkDVUPxnNNVas0l0xnnDkYQAqTNdgGCbSGDEDD5YPOvWz10xMcS2z6u7ku796Rwz9VvBVvyctm641sJl1IcoIRfdobDQGK3LvuV6A5xGLG1mvSkGBEs.kniByQGmjiXxHivhq0Q8oinARwIyWpxrl0rb+JyYRGpRQntuIkHgTOwt3jhKt3r4H4jQuezMhoie6Oa5Xb+tG2sxBBBA4nVA0kTRI3IdhmXAycty8TIhRZnV5i+3Ot7oO8o+wW20ccILcemMvoHfjIXNQhEEw11bjv4Alx.AUA5AdetA6ZKtFu9CjtcTJz9KoauUmaCmYMqY49J.QcYVMVyjqR3LcJvTlZI9rlEpQF79QlYW2O1PqG09zTzcssUPBadBB8jnSwkOxl9takUVIJojRhbnayv8eIkTB9U+pe00L1wN1GwM9K8N1wNtfK5htnk3lPhmyiQkUVYZWFExdLrgMrt6hPFCkAQdAKpmmuVR5vtvPrsPG6325XbhFHdcTJ58Vri6zJ6cPhsNnxpGTOwxXglt+HAz8InNyylqcoApk34VGDYubW4S+gh84fau2.FNFIknWawJ0BB8LwDt3tynRDIoC4LsoMsWcgKbgmoyE5TXbrDIeS2zMs94N24NAhnFxvieGvMoualYim9oe5+eiYLiYFohUoqrxJwS7DOw293Nti6AxlIDFgziku7k2cWDxbzoe1qyjndfYTsz0JnIexDln0O9aWXB8bnTMCC1YBScc90LQb2mf5LzkOP1UPcR2WNESaKtty8.ybniHAF8DuuVP3nWbkEpyDQg6YO6I+y67Nu27cdm24ji96bJf14uWRIkf4Lm4LuoO8o+CIhxlCgmqgYtva9lu4U7W9K+kwjJa2EewW79tm64dNiAMnA8QcREMgiBgHzX5uw8DSQw1h1BE8ciV1aGi+tgHzPhGu8arEPGxX1wZ65Pm4ICPje3OPmqOTmROWk65b4CJs6rSlCm4trQ1z.Foj3bF.1IFwX0rIX61Tr30QCMEJw51EGwzEDDRJcpQ4i0rl0Lny67Nu26cdm2oD2tMCaXCCO0S8Te0JqrxGu6x5tG7fG7TprxJeqMtwMlRwgz63Nti+4LlwLlNQccCOqvQGnyjn7QOPKT6LtZ6VUqsDH.pM.i1fcVtwOG6TIdrv4ZkXoHZzBovAIS.u8bb9dJy8sXWitaMSIlwVnNa9NiTZBNpYfF7agl0ZzD.ZyQ6SkCWVJ8jBGNNUyDgVgAFfOydbtxkfvQyzoIn9UdkWYrSYJS4sqqt5b8M8WzEcQMtvEtvJKojR9fNqxUhfYlV1xV1243Nti6dps1Zc81URIkfG+we7K4bO2y8oEW7Pny.JSRrGZx0oP4no1Wdk2iQa35a2LxrN3OUgSvgQ8SxCAtrRQAi8ThqfTFTy.wWLcrDczLqPdCa33htoY.xmBVlDXlaELpmTTiLyM.laBDZhA0HAtIlolHBMyZzBYflXMZkYcyLgVUfZkUnElUsQZtMF5VUD0leE2VaF976+TJYKo64srNTFkoLSsCkNyDuyLSo8yAIidRBpS54bm9HsF.Mx.iYReYLzK4KAsOCDRPMwZjoNNYn4Qjl.Xnfpzh.drGLy1oBBBYMx5BpYlo4Lm4b0e9O+m+QRks6W8q9Uq81tsaahDQo+PamAvL6Ylybl+ia61tsKKUhJDidzidGqd0q9LKrvBqtSr3IbzNpzedDnUZeo6196uga7TFfUP4sQqQhovKygZg5TJz+S+zS39UwgsPs6F.aB9IBphKA4eQSTcTWGWyvLHXp.q59rPcOLW9Hk5XgErCnN4cLCFE7klTOlQ2PPPnqgrpfZl4btnK5ht2m8Ye1qIVeerl3gkTRIXAKXA20Tm5TmQ2k+Rum8rm9OoIMo0rhUrhgjJa223a7Ml2BW3BmgaRS4BBYBrFo+DyM.kS5tokZwUNLedfAYm61BQ3AfN5nQfBUGvB97GHwZjcDqic6PfqYf.pLaNczaElL5xrPMqs517gZk1el5bvYy1FIuiEbnnMSnH0AfVbDCAgiJIkET6HheDZ1QjK.F75V25t7gMrgM6ctyc19iSRV3sqxJqDye9y+xOsS6zd7TsbjsX8qe8S9LOyyboezG8QsuL2DR9toa5ld+4N249n.Xzr8FDRwQnOHpkgf+TG0eG855b4wa8PTeWx1FmUnXs7n+oNp0O58gaVdx9tDsL27c.3nGwUDm9SJQh3BRmsiYVMugeJ4W.rfhB0zUE76zA22A+612HfF.CxJwWVzo4De6n0ohE0EFkOXJiCadgUXlxaYlk5wyxjT2rJ5QyjoidaiJHbzNlyblyLkdvWrxtW0Vas3Nuy6rCKOZgoN+6K7Buv5m27l2XF5PG51S1wjYV8zO8SeqaXCa3OjJkUfvh5IhfVqiHVVWSM0fwLljGDOhtiAkTRI3cdm24Dm7jm7ajpkGgrKSZRSJtemVq0Jkx5ZtlqQ+M+leyz1Js8DPS5FSTpLNrkhi42WT5bL2111li3FWjQWfnCs0QGknSVRsfzVMGxxdNc4CIUKGG3tNenVkfN6DN5qzw3BtCxfKeY1nTlk6fc6iJDC.v5NztO6ZPbAAgdyXN6YO6r1NysIbke4u7W9129se6S1M9KMybtyZVyZIyd1ydxoxwHcKawoLDweWSM0bjQrM9HeT.PMwINwt6xQlCQ0ywMjbEeT.fgpeoygrrxJKW..lbuAGC2g0jI.jZMV2Ol9l17Hd5xbqLMk9w77fnPZ5KzLzosfZVyYaiC65QExtsrzMPAgilIa6C0I76Cltum6TlxTtExEYDqpqt5gOwINw0rxUtx1C6dc0hoED5IfJfyNe1QYmwxxzFffIXPfSo4FPHxgxou.AumKTbbNTTKHNaSn6yXfDFlb3n7gZmVo1491YFR0wxR+nHQuTxBSVOWiJA9Nb3GZG6S+Au9a.WDgLhyNH8EESntzdaiI5Zfy16TrB9hA+dhr8m5ipZUJHH3jN03SSqqK...f.PRDEDUPsSprxJwS8TO0kTQEU7TIacYlo0st080Oiy3LVnSeaNcQDSKzam.drpO0UZngGFns0swSJcNllVViTQgE3lHWNw42oAPAETPBETqUnYmNyOPri1GgESyN+gGjhQfgd8zEF17TARun7gBs65Q9PZGKqynvlW5GZIiAVDcvzcaOZrSeBBGsSWhf5oO8oW+blybFcokV5NR15xL64gdnG5gu1q8ZuprwwNaacZwZ2BcGDfLaHzzBDfiokaiDFFffOvPWasmX57Bd+UU0WgXNXBU1VvbbsLsCowVZMNlQMhDN2HJcPk27Nd+MfBBZgu32YgvSDR..EAz391We.vdcSc3im+h5y8+Gt8KsP15r8w33AvfAPIL37UjJFwiABMSJb.CC7y9qy6dK8KbVeW2bb5BnKzkOTosvTECzzAZJejjQnHdvYlOTWeFrsc.lwgC9aw3aidNDDLSHRZ.6Ae00c5alSaZ4Xth0bwkP3hYhOEl4A.fBIhMAqhHoLQDoB.B9gBCZ7mF9FK5AD+LQPnGBc5Bpui63Nd6YLiYLIhnj9P58t28NfoO8o+1O7C+vo0PTGKx1heEwz89HUhq38TYnULzFVEaE1kKbQcxj.xiH7QqaCpxl73yColOgZr04tfusOhCNQrhe69PVmNzsFLAXYPaMQ6+92+xZZaLkR9KsAXbfcua3gxah.3e6lsosO8S93JHN+x75E9bY7W3vZBHfE7UZ+5wLoiotPW9PqSOenl.vlV+FPketSe..X2o0AmRR3VLwjUsPcY8u+Uac386p00tylDLYBdzDZbeM5pN8Uc0UWv+4abC6xiWyRJyf.29z8L56LBe+daPgFBnQwsIQqUAgdRzoEwLKt3hwRW5RmyLlwL9rtQL85V259Bm+4e96MaJlVP.3HiNA4ujBZnMNRWtHY0KS.TrhvFW4JPe8U73SkiWq6st+m0tjknx0v.fXaAyN99Hi8h1+VHQ990.8YfCZSIZ+ao7znkqRCyp1s9mWCCzP0UC9v0+acD9NiK6e+uegev5We9EnH3kzPoPB+P1w3ZnHBAH.ygNfDVG5hoKS8DQZWKL0Y6.OJE7XAXXgOS5drU5LvB05zO4GEKJaHGS0VQzpOwsVM.PdJfsrt0COdTSIY6elYp35rdx89gaqDeJBFJ.iPsCUT6eTJBDws2N0jrGoFqi.dtlfvQRzoHntxJqDqYMqYptYxGxLa7DOwS7mmxTlxKsgMrgNihSL4HAqVJ3NNR3Zs4PGYSsoTHfi2gp5PH7JRTDP9FJz3A1M16S+r+ClYOIbCBRCU2v.22+5wdxCs8sh7L5n0oiWjFgAfECD.ZL3S7DR3Myk1+xZnMN7jbLQDRvtWhPArEZdEqZ39qq4yLYaW96Q8G19lVGxUYetHxP0dG+PAmUYVAiQcsZ0xmjzBWWErtKSPskEmVVn1D.6cqaAr+.WeZevcwjUO9aKmUyxtsYQ6yNbpmjP.YvuWQ.4oLv1275.NXcygYNgMt8WWymYqKcUeghXM7oPvtWFxEq3H9cJX6WUvTYfevHmBxulLtRJHHj0vblyblY0cXQEUT82xsbKilHxM9KcQ+ve3ObkyctyczoxwXRSZR3HhPglPWBSXBSn6tHjwb3B0M2J.7qYvJJX3vK9VnxdB9wvfHzGSBO+cbGC9qO7Q7ZLySjHJtBlZ8PML5.uaUu1Kc+y2y.LHjG4TNgs+LGOeolYf1XM7jagv+wereXhpO4LzgzPKbX6dGcrnlhJJJ.vvKznLSEVx8Oeb4m6DVJy7fIhNTGKGL4eeMeqK+Geq2PgDfOkBwy4RBGWkCWIBnYbri33QACX.cXe2cAmYSVuTBkOiFsupSfYMHx4jNMpnaQvRGS.4apvNV2Zftl5Ny5qu9ATXgEVcJevoLIz2k7QBMUX3UNl8s02cs19vDwvo8mh2bXviBHehwacGyo+e1a6W+qYlmcrl6B0TSMkxGn1ktn6ZtnLC.usKlNwyUAMr88ml0LF7HGwlyJUTAAgrBlyd1yNqa9tezO5Gkz04vG9vicRSZRu9JVwJ7Eu0IVS.vYNyY9XyZVy5qgtvg.s2DxLK+HSF1vFVaiZziCs8tqAfU1S9I2.wn.CCzZK0iG46eCm1W9V9Q015AZ3a2hGqmqnhJpV.v6d261W+xq3QgZZ3Ork69AOuWbAyGGqAiR8XfvMmR9wyOCTmEigOtw1bwEW7gSz5pF0vquMRg1Xf7i4Sf5nw8TDPIll3SOztw+7F999th+u+3t8e35u.yRJXUv94AFscnFN919vpef07mlyY7Au1xQ49LClkGi+sE1gEPaAj.D7yVXPibD6lHpKKxZ3B5xddmYo41DfcDrSorCQiwqyaNEV5SofulpCa3O8mQk+u2xaz7gO7TxojR9X2DhTamLvB0L3rpf5ByO+C1l1YpFJ74.mhoa2kmBZI4hMMw67ROG.gYd5+3ezI03ANvLVxRW5du7K+x0.vv+ga9yZ8we5y+uu0ehOesTKJ1qm1q1IpSxgH.HznlwfOgie0Yq5pffPlSWVXyKDLyzZW6ZukJpnh+TM0j3QrJ5rS3C9fO3u3q7U9J+dQznvQaPDoeqe2bW06tw29bBYAKNlYtMabFuf8PD5mWS3qsFvR9MyxSA2y7enQMlJQeF7fss4LqwaV01wVem0Ap45wvLTnXSJJgnIy0LHXQJbHKK7Em7juyjcOZgibPMTv.FLBbv8.VQQDGsiWO7scICKzOOl3vaeK3Al5E6a3m53d0QMlwBMYGgIN7d1MV+qsJ3ok5vf7Xf7T.QJlNRKrpABJlNjUXAZSyXjiaL+0jTg6RgUccBpar7xa1J3XDX2EivQZknCchsmHeBNBB82iGrkWdIXyqZkULngOpcbBiYLnpaaNfXEZviBC7rFOFzDOy3ZDGNChC0DmwIjlHnkINl5C7WCGmYhcgNn6d3X9.TfAgxgA19K8rXKqbEW9XNqy9xG2fJGevscmPw.eZUUg28MWIJh.5qGSPjNtifRzvfPqZFMQJ3oxw7bYdsTPPHaQWpfZl4blyblyybK2xs7ERksqxJqDKZQK5BG0nFk7.DgiZ4jmzD++81Ov8cNAX.ODA23Z3D.HhgWPnOdLPwFDZp18hpV5K.+AixFFPibHBCPoPt9733E7QFx5RFMFPC+ETDxexm883hUukQNtwf87e9T.1HntD1gfsNlZqofVILWEgb75A8UqQ8u+Fvqs40AKnfBL7AfxLTHOulvNFZ6d8YVLiV0LZgA5+ocJK10aXW.JqtNendfCbfs3KuBQq9aD4RHh1YIxBpFDi7LHjqxKZ0pUzvV1HV06sd3GDXF3fPgOWR8h+zeRI5LYAkMX7ie79u6S9z2WyVsz+7THo2uofcaHEATnAP9JOnQ+MgObYuHZQa6pFFPCODgJ7XBuJDbDfRrX5PiB.CXWI0VnrQd7nw95ciYmZpffP1fNsn7Qzb3Ce3Jt3K9h2SpHllHBSaZSq0W5kdoQIhoENZmlFoukmWeGDZvhg8HQ6hIzGyAGoG6I3jghQAFD5mGE5uWBCvKgx7ZfR7nPtFAGwcNZ+WFHjsJ6HAGpZVgFrrvYeEW4ly83F7tRV4hHhOtwM1muIKc6S8J.mB15nPCmeGQL7ZPnXS6x+.7Rn+dUnTuJjuABJlNVBULhZhPFtdoAP8ZfJNkwpK3jNosjr5PWJYxj0KkOTj0fpXD02DG5pqyyWJDc6hPoyGNXLKmHF9TbvqMdvf7ZhA5yCJRA3MY0hLndlJQmD2RketI7v0ZoSvvCX2NUC6yUgl7fgZile6sQCeuVe7nfWCtChoi2j8scwzAaq1rEiS+KcAuZYkUVVMtaKHHjYzoKnNXVO7pm7jm7G9LOyyTRx2hvrfErfc7POzCMv92+9usNqxmfPuEJqrSr9obEWwSeHKMZKACBsSLHBFNLsFAFJhgIwvWvOdIFFj8xsEDkJSqBErXB0awHPtEgQeUW4Wystj0wL4yZtp7JDMp0P6hsHx4SgcY0LX4OT8vzQ8vMDVDCgVXfCDPiy3h9x+QhxnDLR1mtPW9..3yLwIrnZszvuiWQDKAeQ59Gg8kXUv1TdIM7QZjCzvGrfYRh1gr1eFDkOTYUKTC.bhSXJO1A0LZyQz9HVgqxXsr1OOfN1FkhpCiLGe+TODZFndKFM.CLpu74cqYR8RPPH6SmpfZlYyG3AdfENkoLkGMUBIdCcnCEqacq6Ml9zm9ICfZYlI4Sje57tpIzSl9eIe9YzX9Eg5CXA6lAItoPHKmE1Rrcbabm.AaA.QaeRF.My.6NP.bVW9U97dqn+uiaqK4brCdomz4LwlOX.MBjzNHPw0ewirrFJ5TvA+N6y.gECFcDTHz5QnQKMv.GD7c4m+e1s0gtJXKitTA08eRmy+nFRgV0g7j5Xaw+vslhtkgMcH9kmjXmrAYl9t7Aqxp9PM.Pwe8+mM5YfCF0aoa+9snmr7wKheDxEkbkqYQI9dRBDZCJb.KKLtu3+y65cXk20EiYEDDbElKaYKKqMA+h9AMyXFy.24cdmo79YpScp3Ydlm4LW7hWbVeH7NRgrc3N7HYt1q8ZwvF1vNhnSH4VQEez6Ou6+4V5blyWtPCB9PnXrbxvoeIGIwTLfKTAvffECbP+APtUbB5A88+ZWUpLggIhBzvZduu5FW8pd15ZsAzOSkigLO7DfihoTtXWVCIto8IKWDg7sXUGXnYBsxDNX.FWz246rfhKt3C515PWFlYTFDLkImwc7u1Pqbbn9M7VnHkoi33c5gahdE..AzpLXRIpaMc213tOIpsO5AWzcrjeyrukhULxIXLM2Yat3cuhaqy.cTTdjQQDBfIzP.MZLuBwY7i+AWlLw7ED54g4jm7j6tKCcfzQDtfP73HsXV9.t5K4qW9qrhZ1+lVKFfWS3EN8B3PDKq4FNB2F+HoQnzHdrs5l1wZpYf5BvnsbJDW8u9mMgh5W+pKUqK4OtSbImwUcku15t+66rJwv.lDCvLLnfVWlTwTXBgPKOJK40Agegr7ski+NLLH3GJre+sgx+LiSerS6xuYL8TsVjHhk+nm5vVVcotfBQTq08hq9m7veu29O1FSvGk3rZoy1KN6.iSmMxMXRouKevb1cRIFhBtvoL6R+G+qa4P6XKnLudgW39nxQ6ksf+Lt22E08ZDHnYcPiTYm8QOT.K74+1e6+e4L7iopTuVHHHzYSW1jRTPn6hiDxThNoO8oO0dd+xe94WWdEiC3WC+LAMSvYZ5ti3LsoXSh7I1DcNKjkoOb.fO0hwT+g+vasnIbZuV5TWHh3S6mcSmeQG2nZsZ+AParJnqcPIoLjBV+KtqqpcKrWWdEi+mY8yu.hxdouZ6yuYqGw5K.PWaa4B+hm0cLxybB6aeAutD+zMRriKyoCrJoSaw3hxfx5VnF.ne8qe08U9C+guQc4VLpIP.Xwczwg.Rt6r3VXlCKlFDZEJrG+Av.+Liaam7Mds+7rxAQPPHqiHnVPnWH4N9S7E+12yecV0kSg3P9s8AYFTPam4HitgPRncjY6X2mDIbh8DmxVLc8AXTc.Ml5u3WcW8+5txLxmiIhZ3Ru6484pNuBvAZyOX1tdDK64ExmniUT.IgGCXfHxzcfP.lQcAXreMv25u92tibF8I7RYR8.AOBFg7i6DECuSQcwLo0.gEsEaOVN6BQTfINqe5Ys+1utjHQ0g8V+3t+RRmj..fUawYmniymvvH66xGgH2wNxG8J90+hEVc.6QkQ29jTLb6ThryfoTLmfhw9RdrtNZ6xR1mqszD1eaA.M7Sn4Ib+2w3IhjDZlfPOTDA0BB8RI2ybL210Nu65OdnbJD6os.nY1.VwZhJF8DbJFYfzjisP81XE1e.M93.Ltpexu3tVvNeueX1veN8MxxW2MLu4cg0laQ3SayOZRSH.ScP.W5ZfV1wftqYBswJrO+ZrKKFW8O6Wrv+uW4ou0LodDY7GI66dqFjxpyX+lLxcjG6GbC+s697pK2hvdZye6VpNQVqNdDxUhRHYfOTyZtszcaSFDQbYW1W5Zu5e5u7euaK6nASarBZlrcwEG0qLcTD3fsQaTS3S8agbF5Ha9Jl+cLh9kFtTkffPWGc4YJQAAgrCDQLy7O65l+717BmwOeg6deeJFfGEJvNHLauNfisJzfw1V6LtXnXhK.fpC+scTyvdh6se+sg5xqX7090+xeT+tzKXNyNKN4nJXBi+4ZXia4Bdr+2e4yumO38w.7XfbU.Jx4zRzgUliied6jvxnCmXLbVOt964u9ax6LGyuNcqGQq9yYFpLxkFksKR0iVfVsb5hNckyPwBN6w7R0u50Ok69F99K0po5v.8XZG52HBYKeDODQXI9HtzF+8e3H5hUmlEpA.HhzLyW0E5Qs8m+OMmedfVqG8wiIxAbP2Tpi9Yty1eQtDa530QkcjywhwdCXAiQb7G5Ksf653yu7xOPVt5HHHjkQDTKHzKlfVU8u2z19jk+d26C7Bq9oVzI2GBHeSCjqRASngC80AoiVrNhoOVv+Vy14YvVAg5CnwgBnQ4elwUykMye5YW3XN4M2YTeJXzmvKzz19ji88uuErlU8jKp+ESLJwiIxgreXE4ntjbCAFJtAC3G.sw.0EvB0Xw3X9Liq9u5r9keg7q73eyLo7FoUiiUAhQGSb0og0cUNsbaW+bBnvydLKqg26iF7K8y+0u3Nd20cpEXPn.CE7RFvaLaiEMtzexC5C0ohUdCstL4oSyB0NNVL.9EMrh0uhm827aewOd6uO5ioAx2TAuPCSxNT4YSx50D09ZwLP..zBCTq+.nNMvYcIe0mtvuyUckEUd4cpcTPPPH6fHnVP3H.xajGytl4Lm4m4mrvEd1O4cN2GY6qaCCouT.ThhP9FDLCZAMpcKWaSzQe.aqVaak5V0ZTuFX+ArfZfGi9xmwO76OfK67e.hH+c10El4AOhuvjtlkbO2+8uiMtNU+IfRLMPNFJvr1Q8HxPhWDRXBFt1aiYTukc8.CbP5K367ct4iaZW98lMpGFfBdPUwNddiHSdLTD+cpfmfQ4CEryJgIeKzP094frAEbRCaOLyiduO1yO4k7.Ov8+AaaaUzWEihTDxWofGJNwi4Ps8bQ8lsZSClfFpf9Ke66kPqQD+ss9VEHvvvpyykOhlBl3XdoZpol99oK7Iet+y8O+yL2FqG8yPgBMX3o8P1nSK3GcomBdML3DOTynl.VXeLvfF83a8ad8e6KJ+u3Y8xR3wSPn2ClSZRSp6tLHHzoAQDJojTJAc1qkYO6Yqm8rm8JYlGZKabqCayKbQWy6r5Ubq64.6IeO.vmhfGkBdTp1ic0gDlQjcxMoMsEZS6G9Yaqkcbm53V+T9RWvOq1IM1kOvQMptLKkELSE9faZSa5Quvsu2I9lK5I9ya5+tpS0aaAPtJ.uJCXpBNIvB5S3gBwXZvHflgeVi1zLZgAFvwc7q5xt7u5LG324JVMQj+rUnw6PdMP0VZ3yxBfCm.YXGBHC86gbxl5TlnOdLRoiC6grNngAPqsgbYK.nfUBEopQKjBGxvCfmzu9EMAE3sTl4g27p27P1xy7jS8CV6Z+oUsysOPugRw8TvP9li3HN.gZTJL7jUV74UePCCnaoUjCrBNYRAhVPsx1Yk.CFMCBGV4CrWiN0N5EMkTRIGhY9rFw4+Eqrtk+5+wkun+0WXae3VQNDfWEAShfGEAEwPELLOFJmboYFAXf1zAPyZFsBE9LetIfK5Jthe9dO9AcGEzEdulffP1girhmXBBBQ.yLcv27MKr52bSCeWa8CNoZ16mV46sw0dBFvX3FLJUSrW.pVEvgBvztFxHG45FzvG96OzwO5MlWECdWUL4I2oDaeSGpppp7k+67gUrs0r9ScOa689L6ppscZM2XCGCQnLESkBf5sH9fLq17PFwH2zfG4He6xFUEaNmy8r10obJmRmh0KqeCuOG3fGxN9pncSZaWg1TJn5awnOi9jb8ye2+9e+BC7dG9D8zreWOrhALA76wCLOoRe+xJ6Dq2sGqzgpppJeGScsMfVN7gOVChGFrnSDJLR.dT.3DHxvWKFJT3vJG4VwwF25892+6WXyabemXd.vzkwyh.l.MAfbGc+6zqmIBlYOMskOtrO9kV1f1419fgbnOYmCbKuy5Ky.bYljQeXXUpFTwLgBzZx7DpbL0cLi5D9zQL9w7188zG+x7Lj9sQhntLqrKHHHHHHHHzKBlYEyrGl476tKKBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB8Pg5tK.BBBB8Vo5k+FbdVLX1JleOw.LE9m.vOyb.vnQhPsLy0AkZeDvgzZrWP58SJZuvRWMSX+s.iClyocpGt3hKtQhn15JqaBB8zw99OKvLaufPJZ33uMsZZfBF5PPtULjdL5eXl87IKeUWb9ZiSzPaUtlQIJE7n0vuAnlYnaBfNDLnZ0fqkBf5aiQCslipwbN4ieMkUVY02cWGD.L6tK.BBBB8V4u8s+tX.VA.CMnXXeBEHnAfBLz1KxSvO4Bf9k7i.AK.3KuBvydQeiFG4XG6bKeRS4esF9Pu+jm7jCj8pIBB89HY2+EMDQ3PjBS36885BJctm5doUM168F+AOVezVHGV6psoUnvAUJ7im2ccF.3s5bKgBtAQPsfffPZResrvv84AFDPrMKlKLYVBgfEC3OPKnosrg7W06s9edsK7A+49Fv.8+1+t4cKCdZScAkWd4Mkl6bAgd0j76+hDhTXmsE.41VrGQotKT90GaesXTQNdQAvcksFfBTq9A72IW3DbMpt6BffffPuUBaSLFDE4G.MHJzmN98w9SGWeChgOEPwlDFjWEFtOB88f6wy5df64td1y6xZbyy5NuNlYituyBBBcOPv99r3e+m8uqH.PLXVGb86gAiACngJF0iX8AAqebZ2QcgNCDA0BBBBYH1u.29isHaFT6VMKU9D5E9N1eDCEogIwHWhQQJF82TgJ7Yh96uQrx+98e+O34eYaug0rlA0EVkED5wPxt+y1kPBK9jz8vDhRT+s+kHu2OweD5ogHnVPPPHsIjHXztOb5zpQNsHl6dXqB.pf+en8ezu7LrH6BL.J2qBFa+8G5ee5+fc+oOvhlZ5WWDD58Rrt+KtqK0iY9HFhxRzWF94A1PA+6db0hixQDTKHHHjEHRgzc1VPhAAFlDPdJfA60Dk1VC3e76tsm7Sl++5GwLKuqU3nJ5Zu+KKiFk57O60U9E.fLoDEDDDx5DxBXDo.y1C+LGzFZbveKQVRKQd4o89Kr03nfGuRMI3QYfG+Ob6+oKSw4AfaOqUgDD5EPn6q5AZA5DBSTec92QW96A502Bw.wB0BBBBch3T7aHQztYXoimUphsXAaqUWhAixMMvi9a+M21gVzRt5ztPKHzKB23tGNueR2CSuMQbQc2kAgLGQPsfffPFQ5L7r19Vcz9FY38HAD7CE0ZDY71Mz5EpbvnHCfgZpv+31+MOZyaXKUjFENAgdUDRHchhE08nsZsFEE8Bh7SrQ7rqdVHBpEDDD5IBEoU2RjU3BO0EYXP.80TgbapF77y4ur5ksrkIt1mvQEjH+n1MI9ktMHje2cQPHyQDTKHHHjQD9E0cb13SNVGmuP2dMim8mnfS5v1C6WLGgXAJJqR6buqfcXDqOd8hct5UN3SqIiuQZW0DD5EBApCVjtGcLalPNQt.UTeh210CtNcTHhkKDDDD5jniuDmflAB..KnZOJ4F4ZPffFF.v.HXRovd5LFq8qyIoX6eGCjCAzOB3Um+7uWl4GgHRxoZBGggc.jKzD+EHnkooPeWXrWdOTqTyH2zYiD5YgHnVPPPHKQB71QDJut0rkFGNfEZgUnM.DfBawYh0vCofWBvKXTfhPNJBlJBJhbjbJn1EQDok3r+cifVtpudTX6uy57zv+c8SB.ubVt5JHzsRHmgB.HrGdPH1ymWUvk2Sbf4ofZwBEW6icYLzR0PC6taKzSBQPsfffPWBL.qP.Pnrgb7XB+faFvCAnh7kmsr28fCt6ci1pqNr80udriOZaHWnQQllnPCBFDZOT4gDXoZB.9HB4qXrtmaI+BHBpENBiCYZhs2Z.DNCCZiJnjyvoGoPAsRBGhHLBO8zDUyh53i.PDTKHHHzERq.vnzhPAW5ji63OGLwrnNlO5iJzas9Om28e9uV3pe7EUxwx.kZp.HFTDt.BhvsPzgVJAjmgGr4ksxIxL6Qb6Cgij35m+cibCnghibrgHFHdA.iVLTnvgcr.+3ueWPIzcPDETgusKrD1RzQR3+VxSh8DQDTKHHHzEhECzrJwFjhHhAfE.pA.OKy7fNoy9bdqG6m8yNUzVinXSBlNdeZj1pNR7o.peu6F07e+ukCfOJaTGDD5Ivfl3YJpJE5wPOsw8PPPPPHJHhZo9wNpO6k+y9E0uaKMZhiNpgDa6UQfgGhPgDg.uyNqrKovJHHjQj3nOsPOUDA0BBBB8Bn7xKuIeegydRCdziEMDvJXRcH5z9Rjn.fIzHOhvmrssNotlRpfffvQeHBpEDDD5kf2xJY8m9EdgatIKMBYS5DYIqPwBf7MHrqpp5y2ETDEDDxxDNwMIzSFQPsfffPuDHh3AN4INq1.g.r6dIKA.e.n1p26IyRtJVPPPnSAQPsfffPuHzEU3aOjgMJzrVC2nOlH.uJfCdfpwt10txIoafffPOJ53LlPnmHhfZAAAgdQjao4dPOEVH7y.ZWXiZB1t8gW.TbwEmWmc4SPPP3nQDA0BBBB8hXsqcssdBi493mLL...H.jDQAQULnEM65HA.QD.qgdcuWgcpENAAAgiRQDTKHHHzKhwMtwYYoTH.Avo3iv81F02NohkffP5h3OGGQfHnVPPPn2Eo8D92O6uOYyBhfffffMRlRTPPPnWDDQbU21bSqsUAN+rQYXG6XG4Lf8u+xZ5.sV9t+vpN1lqo99nXJOnfeMgCcRUNl81jxZm8+7lzdAPiAy7i8Znpppx2.aQWA+I6cjad8a3DMIpP..KE18IT4n2h2JNtpxaTCYODQYT92X+6+8KTst8NzCsq8ebGZ+68yPfKGP6ImBJ5PC43GQU4ehi5capvbqp3hKtldxmCYloZqs1R7tkO3TN7tqdr6ZqevIXpQoZBM.C5CG1wM70me4C9cx6LqLiOm0SiMsoM4cDkTREMskO7zN7GumSe+UumQpXJePn9bKrfsLjieDukui+DVaNCo+eDQT.2rOIPf6lCTdLyTc0UWexslFNol9fcVYy0b3SeWaa6Cmz7.An.ZlqouCd.asuCdfuaNkOv0nqXHa8sdq2p5IO4I6p53QhHBpEDDD5EiBwOVTG8qjCXvEmNGClYp4M+gCo5W7Ut7MshUdyK9y+kGhW11gSTDASUnA6TCKlw5zLzjB9AgxG1HZds25s8WG0W5BVXASbbaNaJn5CV3SvqYwOGxyxBdXNTY01mwA.yPyrtUPpZInqlIUUMZPqrZM+O+AO8e+fQUGUMt12uxO44dg670+F2v4T+92CL.COJELBt+rXFqWqQ.nvfOtQhcNm6edk8kO++ubGQ4ehaE7V+qsg9u0mZwW8NV+5u0G8ydYC1Kyv..dLBOt+VLgUq0H.HLnJFENsuzEr6V21d9guase5SO9wOd+Yx4r24e9T768DOCJ1e.DNo0G0O0vO.2BqnCQL+Qfoku6bL+qW2i8f6OpyYFM9Zq+7d8u2sNu2c0qph.MUOLAfGkBDwfYFLHrNMCKhfYN425Kc0e2e+oeMek6pjy+7OTlTO..96e0qk6WqNqGggHBbLthTqoANkK8hvob0SMibzhlqZmCeeO6qL6+6O7W80dkcTEBeczn80wh4KXUAauLnJFI14bl+eqeW5486x+XO1OMhcFSs2l0dpFqhPTc36tBt5nyKSJ1P0MLP8RWw270+d+je91W+5xul8uWXBFJvva6sQsKQAz5SK.yfIBl4THFwXFK1+88Oe97m747aduZ26Zxz1pN49tpuE2mV8i7sR1sYLH.zFQnICCL9K9KiQbMWpquVuo+wSwa5IdFTb.q12eQe+AwD.w.LAmAZIQPsfffPuLBKcK0dspGXTTpr9LyF08Bq3Bdlq8Ftu2e0qZfEyLJ0PgQ5gfWhfRYDTzRjunMTIKfVil201ycC67C9wK6Id7ebeF4HadGO3htggM8K+QIhx3W11xGuabfMtdzGCBdYqXsJJFbtDnbAv.YvitdXb4Uao+c.nnf0Qx+Gu6ydM+96ZQu7Bl+.KCL5ihvf7Y.CRgPB0rEnw.vDAXMp+i+.77y6NuwldvG3FmvUcUuXM0TyUWRIkDWQhsroO5jV0872l2ecZe8IWF.JQQ338Z.ODgPZozLCJ34RFlvhYT2t9.77y6NGbKO3BVz4bUWUyssyO877NzxWU5dNqoc8IXeaXsvPA.xYaIGmzH3A.dzLJDfFpFXhGzReM.33BsNs9Q6arK9Z+AuZUqZ4kL.RiAZXhb7YByfUlvmuBV2.PqVs3auu0pm08+lqdV+yK8ZtqO6Mds+uUL4I2R5VW1yZWK7Y.nhgf5XCgCnYzvYL1z8PhZ14NKc6+8m9eeOW1U9Exow5QeMHLJOJ3MXmJs6BQXUVLLQ.sFMrqO.KYdy8FZ4AWvM7V+949bm3M9M+VEVXgUGZs3nT+2Uag5l24NG9ldjE+2W3Tuzyrsp+TTBXThoIFfOSDtudgJSNuemfEqQqAZB68MWI1xarhKns4UzEbxSZR9aZSa8am6IOpG0sVlOQrq29sggh.CsiyuQWdB1ADBnYF3vZfVqrxT53zvm7I3.absvT491TL.ZyJfHnVPPPn2G5X7acjnesS.lMh25FMMtgO7Ldku9M97a4MVdeJPALbSCjqRAOPCCJrrOa8Sc7EOJ.30ffGCB4xD5CynwcTUtO+uY1OXedj+4eq9md4eoBt3It7LwUF7n0vGzn.CCDc.11g8jbHugfkFvqFEVc0UWPoTtio4+6Fd3E+qu8Jp6C2JFtoAJvv.dfFJBfh3ra35pGBnXhPNlFngVa.qc9264sskt7C1ZU64a4cjC7AcZEdl4B9n67AdvG5JupKySK0hgaZhbUJ3s8iQXKqqHmuDmgYviSdldPis0HV+Cbu4twm4YWYSu15lWtetwbyoi09MXfbgFEYZB.cbmObgsPJAMSH2.VU..rrksLywUuweZ9W3Eey41b8XDdMPtjBlvttPNDeQN14J.jqg8nYTHSnlMt1evS7MWyz22c+niq+euu11R05A.fWnQ9Flvzw4w3gNXc5PsYAizz7tMs0OdBu3O7Wshc+NqACzPgB74AdgELbb7CceQn+m.COF.EqB2dYcy+99xe3xV4da5c2181zfJ8+Eu9lbbTbNlSp1K6NgP1aBvwLmy9uu+08tfu7UdMplpGkZRHOulvKogGhPraivN9MFFDPNDfGCEJBJzTqMfc87K1y89bO6Cc9S6a9mZYG6XB4TQEuelTN8.F4YPnnXdstiW6MAglZigImZWrMX.ePiBMMQHqcmXHnYflzZYRIJHHHHDFlYi8+XK49uuq4q8e+j2bE8437YfiwqIJ0.HWRCCvAegl8v.qZOwHG4GJzG1B9HMJRwXflJTgWOvZmaK268Vtokt1eye4uwLm1uGRwZXZaKW3gXX33iYT+z9CfWhQNLPoM5q9.adaq7dt9anh11wVvv7Zh9ZPHGxBFDCBVH7KTirtof89KORi9YnvP84As8gaE+kK+Rt+le8MVUa00z4zP0UOvVOTSe8W9l+40+b20cdY82ei3X75M34wPGCGmunHONgN+YRLxkznul.U3yK7df8f69688uwlV8FVNybpaTLKKXPDLBJX2HpyaFDCODCSRG7bpFFvB4RZz5NO3keb6b+e38Oia3l6WqMhiwqIJVwvKwPQgqCs2YKGm6rqOAfWhQgJFk60.U3QU3+5+2uqpcb+K5LSmq+FLCSXW9hU8H55jQvympj51.cjV9389Udxu+MuhC9NqACwiIJyTg7HKGh4S78Acr8xVv870tlqO2MtiZ4VsOuPtP9V1jV9fcMxmd523992+wey0z+Va.U30.kYnPAJK3AZPvJg0sP0OvVPAK3kXjGYg9ZRXHdMQEdTXkK7A52+55u02qw2Xc2bljoVMX.S19d3jcs1f3fOWfgJUuT6h6Oh7i8yD8.IJeHHHHjEQiNOuazIpz5kuLRrRBlYua929WdyG8m9SttA1RCX.dMgWBfHc6uX0oUGSdsk.0taSvfHFdUL5iGCLDSf25Auuu6p+d+jUWUUU4KkqL..T3RPxNqa6Ou.FfQALi1dusfG+F+dnrlpCk40KLT1kuvXaoPFczURzsm65r2FOJM5uOOX.MVGd3q+5Gtd66dkdpSumW4a98966XIOKJ2qBEX.Xzt.kTkfByHKzOulXfMWOdva3FNmle8M7rorHEUxWcM5301B.PKO4RVzSdaydHC1fPol.FjFwx5fgrUaX2VHzdS092nHFEZpP+MU3o+C29qWyyu5gmR0CGPTpcJHUW+V1ecmvK+qu8mpwcTE5uGCjqBAaqD5SbNNcXIgauzOudPYMUKdla96CqsrUjWvNG.ffY.0NW4Y0+Fu8jd5u6MW0AW8xKbHdMQwlDLULBMnGox.GQjJ3841Wmsu9BjuAvf8ZB5CeO7Pemu+c13+Yk+4LQTsSbyYmz4HkpsMBdj.iTMHlJHHHHDAt+gnTT+LyvVrRp8HbEGeeYjY1yq+S+sq4kWv8Ntg5QgxLUvGoss7XVpiBLqAAM7oXTpIvw5yCd+WdIm4xtwe5ZSaQ0tjPunz..4QVX8+e+Vjeq0iAFb3sojHNJt62fuH0Kowf7ZhhZod7b+neLdqYda3.u6aix8XfhTjsaAD7Rez9Kapbr7RZzeOFnnlqGOzs9SO+V+npu3zZmkh3kXrj48GvwXpPeLIW3lEI56r6RhAwnTSB8mX7j21rWyl1zl7lkK1YLLyFe5i9uWwNV4xw.7Xh7L.TwoiDtgPVr1Gow.85A9ZsAr7+wBPtj8jZDHcE04dZZia9btmu6MsrV+nsfi0mGTfA29HlX2Q8L+d8PcZJWEix84E8o0Fve4Gbiynw+yJ+oYdMv8jcju6NDA0BBBBYATs++JGRyx9VrNjEdRGOOVqTGNd6yO8ge7mcsO1+7TGlWSjeDVfCHT8JMJsvovCmBELHB9HMFfWSfOXqm7dtiE7lorKLvJvTxKWsKfks8+4BHF6a2aGE50CHpiVVJr0+iW8Nx5EGTjjh.5qWSz1GWE14atbTlWOvW6V9N75qHkqDUGqiNEzJm8wqI7V8mf26ude+CNE7M9D2tI9sWUfQglDJxjBZjaNtaGCmSotPVl1YMQEwuUpoAZYe6tjhV66+SbY0nKC+6Zui6kt+Ez+AaZf7TbZNBC1D8zNTQLJziGv9aInayD6sK7YOmicP5UNZ5S9jg7L+ne0J6ei0h940CTs2YxPkJtcm4J0oisXs22ZThIgJT.O7+6O82U+qs1yMsJ7NnmXrWTDTKHHHjAzM7fcR09DEJ0N5JvwLJTzzp2v24Q+M294MHOFnHCDbV824EkArESZKnHOBXvd8fM8RKYzu27dvGHaMjvNocg7DAEqgWnQgdLaeRA1wHyP5V20vCAzOOJL.ulvmxtNF1IHB4UwrqsBYrDdSfgOnw.7XfU9TKJ2F1xGdRoZ4L0vN7AlqoQDS.urwwQQ.dHFEYpvhuu6+1Xlid9k1sxVV7yeYFMWGJwT0dDLIaPnXBhhXTfGCjmgYDicU5NJFIh0rl034E9k+g2pgcrULHudgOpicPfB1JMadSHA6Nx1OSEJn4ZwiOqe2Krm8rmrRLwumDhfZAAAgzjnsQWHB+Boz0xtwm0t10Znz1VLL5W5EemVvtD0pkQcQ+M0Vas88Ym8seOkCMJxHR6qGhTuVjXKyGZxqYGGqYjihQeLAdk4O+qo4M9gmUJcnhAwq7RfgRQHee9fcTNKjzYsCqpF9JW5ACCkBJE0A67kpB0sXNtmEIBvmBHeBXcO7+7JS6haDD8Hr.ffmyxwiYvVQwZxyE4Y7Ps+UA+Whw1xr4YnPK6cOngUr9yIaTSxV7tqX4WRtF1yCfN5S3wl329KLNsmuRA3wLbHZDHxQyI7QS43SpK4cTaaO+zcspkMv950zwyOhb+DcazD0hUAJXHKL5kmfQVwiGX8ga0ym9+M+GHkq.8vQDTKHHHjg3NYRbT+L8Xbiab917FVO7pHW+.bl0fIfhG2obvn+t8+Duve7Pe36ix7X.CJ9Rx6rPEzJcEaZfBZpdrl64de9TwEFbCczZeg7Wzrqk3bt+i4j0yQ4vMVfjHJtVxNjKlTngBuwy+bSOcKotmv0oNiXjrWhPIDiOYEq3Jx567zDlYZ6aXCC2mJjeE675W14XPHTnRLJgrI7.j5sZqolZJ8Il6busAZnPdTzS.2n16YoJWzc7h.ibHf9aZfUu3G+JZXSaZfYkCTODDA0BBBBoIgC4tIVZV1TlZyGt495u95gOJVVAJxRQnHagFJXwDZyGEgKevLmyK7.Ov0UjoYvIeXri5rw2dbgrYY5YSaaIJ1BJ7.F80Pg09ROegsroOXBIciSx9MhQLHJQoLG8ZDJ5S.3z62yTRT4vMt7QxNKRfgOEf2FaXvKaYKKKjWIBEkF5ncKctNwOByD4VpC9ujCCOPiRTD1wZW+TSsxbmGq89tOybC528Qd4JTTsH1DYrmIw0ecbhSxIt8Qp+zjZdpW5W0791CJxP4vkthSG+b1NMA6SMXncN2.P3nns881crSBDwHGCBEpzX028i76S4JROXDA0BBBBYHcxSJ+Hvi+.m1t9npfuN7R9NRnzubqZMJseCD6cu6MBW9n9m9UOM+6cOHeC6r0W562lgcFfNJqOwvfClTSXTfAgBIF6Xkq5FRyBhqncWpNhHuR79jUOxo7wIYWS7P.EQJz2W7+Vn6KGo6q9CG56x1mqT.HGhvm7gaqOYRrIOaxfFzf73k0sm54S86Ob1knXe9xov4NC+lN3906+cIKYFEZprCCltPPdG6zTle+AELgPYPLJvPgMupUL8N6n6SWI8HZzJHHHz6lXaomPuTJaIMiYlN7pV8s4AZ3QYDzOUSLZ.zBynjANnFG4HGYaN+tc75uwWsTRaKNGLTtHhYXSPAzAiWtrFf0.ZsFLau7Dkiwh1xqT6YHPMxwfva7LK4R5LlbhQaKs1SMELAsFP29OCEKfcXAdNxIVn6HROqOz4FKMrONZN7xA0AAUZDo0Bi092..9HMZ6PGrOtoDknypIJ5NXOZGpfWkP60Esla+bmc8vIAOOGGghNuqgH.OJFs1Tc..dbScoylVds2yStJEZOmQF00hvI1nXS31Wpvmmz.wSPZxF0hjc7hGMskO9T+n0uNjihP3jqo6sbd62iD59CsBZMB2tEHb6hDd+QnuiQtFDLZrdLv2bqmdJWg5ghj5wEDDD5jHa6qoss+ZFyx+W+6Sr.CifQOhjiE.ZTCLlwNlGK5z785VwxmVwFFs+hfXUdsGlVGVniTfYBsxLpMfEZRaA+rBLAPrFJ3G4oLQQllHWEfY6CurKfHjigB6ZaaUssssMu.nU2sgoNZlfenPiVAP8ArParBVAeeuAa6JEEY3A4YnfIzsaUaMqSo3DLG7X0jFnt.APyZFVNDV3kBf7TFHeS6T3sQvkGN0emXLfskc26d2a+.v1ccAyE3rLPjsvIKlPiZfFBD.Mp0PS..p1OmUngAJzfhLcb6hyW1VtDv.ZrkEu3N0q8tE+4X5wjRdWnh9dDhTH.ynElPiAznQsE7yDXh.w1Q0j7TJTfAgbUTDof9DS50Gy5es23KmOqQNJOv9IBZvbhGgKaqIqfelQcVZzfkFMqQv6+siM89HMx2v.E6w.lAcmC28LOF++auy73jqpx79+dN2ppdeIKcRmDxBYOlPHjDFTYIAWXQBfiZLAPcvQhxfiNp753nnPDPXDGUTmQlYbYTmAQ.WPI.JtPBBnhjDPHPRZBIlPR2c5jzKU2U2Ucu2yy6ebqasubuU0USkjmue9jzcU88dOmyc6767bdNOOA.PKDvddts+2AfeuWZGikyDXofHnVPPPnBgqs9brnW4ItlYt9v28l17g21eFSulfNIIEJc6LkvZeo7cVfPeZKL4EL+GH0i2K7BuPnG6xWeSSIjJQ7uM05qKY52uZFXDMitMsPsycQ3st90caMeZq3NF2Jl8PCtmtF+Haeqepm4AenOwtdxGGS2fPKALRIsZ6fMm6vFmShKgPCfwj9y6tdLJKpJgLVFvDJzcrXXnZaDm266pvLOyS++2Hm9h9u..Z5kO3G5Y2zC8u8BO3lPjQFDSLTPDz09aDCuKrQAMSHrEitszXVm6pwJuzKYWsrxk+aUM2TXyC8pMcjm94dyO487iVvA2ytvTCYfFUwc+lTjlTHa8S.nFhPr96uMOcNn.2FlY4jLtmjvFsX.KMNnMvxun0fSeMWzWDuwk+kZt4lGn+m34m9K9K9Ya5I9o2+hlACLg.J.2Y9H9wKSahRoLvhjelvTps1pBKTqMUAIN0XpgqnYmAU4tdCRyEhHGq4NrF3PwrQqyYA3Bth0+kZYkm0s2xoMivweF4yrkez88Ocvs+LXpgBf5UNwkcm4oI+WfJU+5uqc1wUzjRAiTxXkEWbpyy5GKlEdUN.N20dEXwuoy81s+aV5+VKszR+8t0s13Qdpm6i9ve6u8MGKx.XRAM.EOkcm+5Yx1V..zhgB6Y6a+8wLugLGre9qUUuHBpEDDDFCv0elIf3cr4cXlqcne4i+G+Q+q2ZSSNfApi3TbShBVpHplwvJEnybg+gT+KSuyNaRw1H.Y3QqiE+3w.cYZgk9VtDrzM9YdS0Mkw8XorAGF.WejiE4qsxexC7mt+a+Kzd.Ei5Uomwqcr9Uts.a.vnAEgC7h6rQ.jyDQS4fa783Xlln9Ys.bE+G+6g4IO9yntVqKUq69kGtugefS+hVy1+Ae3qqIiQF.sEJ..U3IzNaHDQynKaMdO+y2vvgt7K90U2TF29xbqFtydm0Vu4a+E24ito5BFJDBg7mjORqsvN0mfJCrm8smI5qplGw85jMSXHaF8XYiq7e4lB27e6Eel01VK6JkM8UXlW5oulK4Q+Q+C+CmePqQPyAUE8dKGK5l7yJ.DvplphLlXjA6OnAwN9ISF2+lIb7Gt0LAaF3HlVXoWvZvJtoO2attozzuKkM8v.3iMRO87edju+O6oefu4c1zoDJ.Zz.vKOOGuz7ba3ltoaRcvmsiEzfAA+D5brYf9LsQjZaFW2+9+QWzRWzYU+3qe+orI8CfaY3ctu+uG5e3i878bfNZXRgLRrVLJp6qP.0RL1891cP.TG.h3ipWUIhOTKHHHTgHW9TnAHDRWTQFDyrQu6cusNzu4ouzm9C8I676+OdcmVKwFLOYpNGR2qLiaoLaMZaNyObiyYN8j51tuW3uNwPYnZK0XRP5SzsNd8hPeV1XBm9Jwxuka5RxPLcBpe70u+IdMWwbN6295FpGSaXli3lapISEJsZMPsDvAekcW1I9gbEl5bVjl.8qAtzM94NbMyepSKCwz..ntVqaOQdcmxzdueo+0C2mFHFmzmw8lWw6r88aYiEdwqA0+Nuz0jKwz..0Mkwsuy5l+bqYZKYknWSKXk3HjkW1l12PjiEQUPi.D6aA0o64+YOHuTsL8HLPmlZbYW2G+Xssg0MsLDS6Verp+7VwEdgefMbntszHh10Z9467Emt0cAfhHr2C2UUgEpO3d2iQMjaTw..fiGgXxDchvPmF.8ZYiwMqEfy5KbiWRFhoSPss01Nm10ugocFq6JO1QMMK55NnT4pu5qNzA2SGnNxMLa5gLKJbbqmtrY7tu0aen5W0xmSFhoSPcKbV68h+J25ap+5ZFgsctdmTLcgeNwfHDDZL7S8hEc1UzjyytisA0S+gXgZAAAgJHoZEVhXTCwHxAO.1yF+x7P0DDw.CCX.6DKqGfm6195X+u7twg14tQjC2IlHwXFAMhunh7V5O1weWAFVy3bVyZ9bYNkpwhDYhA.kkO.3ZcI25sqOg5T6XLnMiK7JW21CzVCORgJehnHCuyC9wdze988sFOynlBX4pTOG4rH6TvZfAKaA04JL0oAvf1V3zNqyCFKd9WDQT37s+s0Vagi16fW7rWxJ1Z+6ban0.EOMk3BC.KlwPZFm80tADXhM93EZ6CLwFe7yY8qGe+aXanYFHjG0V4JwmA7zhRzOj58.CYCXL4ohIdkq+bKz4LhHyXc0+6JvO99dpHGsazfhh6jAEYPjwEtGPALzA6opPahRaGPktwoK3rq.33JQ8aai285V21CL9h9LR3n6Y+qdGO3C9WFxbXzfwnueB2ZqsV6HQBif0Dnfwd5LYXsFsNuEfZd8q35IhJn0iqeYK9YV1a6so63mbOpVMBlkKdkKb7YdBFLgH8ero.f+pmqbUoTUbSqfffvI53JlrVhgUuci+vc+cgE6X4E294bi.CD6zYSKJfIGhPHhPPf7ZY5bWd.ivDn5ZDS+cbg2M9Ho+26syNmrJsERUbaWQTd7gZBVZFw.gVW84dKdxmGGWCadVKa4HxyuMzhxH63Ac71Rp9XKAGwjCGt+58TC0i3HBxFlv.CnAN2UtbDp0F9KEa+B0ZCO2abMqA2yN1JZHfamlY1zydp3crDNiVl3TgZpS8WRDYgB.QjUrtF5WY0XSW3vQGB0qnTF3jGlpehGWwZKYsKo8ojCUH8R0whiCqMwpuh28v0LkldohcbCN4lelkb9mO108c2.bP.xKQiZNQEJDqqJzlvY3kDbN9MGbSj3DhwLFfLP8m24dyd4YjPyd5uvq+Btjgd1ew81PMFFHXJC5zMKDlLVO6e6yFZe6qg.fgJmQXdWx18wFQqwxV8pfttbag8z1ahzgezs7n+k6+dtnTOVtChpPW6I.XNR+y..+wBUFppYSSGGwkODDDDFCfHmTQcHCEFen.n8PF3TBE.yHjAldHCLiZLvLB594.XpgTns.JzDAmj3BkzB1dASnvQsrvhN6y6W07zl1Qx7u2cWGrMi3gIu7mM9RJlVy.VLgoOq4Bq.AKpPT.fgCp6YZKXAvRyNSWKW7vNGQ.gTF3.6ee04kxvq3HdWAaFHBHzz7l+NHhrK19QDYSSYxuTDlfoO5TWCfnLPqSYpPonGxS6T.rooN+4CKFnXIKHWRIb90h2qc9mXZforvE9S8hHQhHy4r7yXGQS61UuduKinfqRDT6+L1YLMCiFZ.rGFrF..QDOqUrr6cPMfET9JBx3EF5HgaHdAUvsKsEMMSHlViErhkiZZF8j+8JI0rfE76YhfcdRTM4ifFF3.6bOS0W6TUJhfZAAAgJLolAwRI5zlv8Mbmhzje1coy4727lzpjvfPXaKzecMhUdsW40lqsIfMlPleWl40MNCKiYAf5ZpYLBORVov7bw3F23Fo1lZLoEOobOU4YkQAgMLftjETmYbtNUeE1FNgKu.SYpdJTcA.DZ4KaKQIB1He94Z5diLP73+sViEdFKCLiWvKkCYndgZZp43t+SgO9I1GWWYgIejXWJR8.oe+lVyPCB0txkWPqHlJAaskGUC2Xqsqio3Pgy.jDpEUGI1EskJs5gWdNzlYLi4MeLxv8drhroIo4l9iV4vMRxLSDVRXwMVrnCsy6dxbKTPS.6ae6aDuTLpVZdOYtzPJddhzYqTDcBQJHup3lVAAAgiWweuD0oKljBJxbpb82T6lqPwmlILhF3nl1XUq+Ju65NODrTGF...B.IQTPTgyXe4ZeIU1BpKXYg3I7D.zZqs5oNYAfsSxIw6mkbkdoAp0O0uhebcjCoAfEXDn816vy6qg5ksgSTZwqv.vhTvVofsA0sW1Gaaytm4bmqyIMehhPY6y4EBa.Pf2mW29FNiS+kXxOyoBR3yS1HXUg1j.Jk+pGwSrM1Pg9.75yHPC09K5TkThDPgF82djbsFvDvrl0rJnqJ4By1G1ekSxGlTZ3oP9X0NUE2zJHHHbhLIsTiiTZMn73QioaSmBaIurcUCNt0WOhoEZc1Kb3y3y7Q1PdqSZtbbQ.O0IKJ8PmKHPiZBpi6o3IGtBQfI6t759y.ddayEVJq97z1UqpOcFWvy00+bYuZl8qvI+Cy1dZlI..TAvAyWvroXVtz11x2tZQk.aaeLRvLvqBQcJHsmOu5WLfpbGnkmdFlI0.kbAvbqk59VMgHnVPPP3D.X3D+aOlkEFrtVvk84tgygHZ37s8jBsTFAgJu6PrkHLrGUsPMP7ElXbe4lo.dNFWqTTYEOrMMMy60gL2NWKC5aTitVzOWvjZPOusV18ATZhLrqRb4CU.c43PyddvjJMMTYTNEDNPYOPKO8Lr1ztLZCUV++erhphaZEDDDN9jz8MTuS97I1zsIc9rjm6VQIr8pSHxa.KF8XAr1a5Fd+MtpUtsBVEzT4DEMp3q4dEPImbOx24MWaTqI.Eq8g3Puus4hVas0XdY6FYjQLARegalq1QN8kWVWwETqUA7bx2fCoRKz54mmRTFFkiP1QMpgCTN0CO+LhMMrmFvUIUIXcE0UfRTNAB5YWbIKHdTMh97ZEhfZAAAgxfR1mFFEJWG+ZlPLlPOVZ7pVLthO8m8Zm76ZMeuhs+TE1macJCeD3ay.ET0LZVWxhPF9HyroKWAOdxEYau81sx2B2r3np3YWP1NhmFX...q0kr.qphr5B.rzkkEp8LAqs9nUpiMYW4eNG.PaMnmu2HSnxXvyUSTUDZZDDDDN9jBGJ6xLJBWpeelnSrUDhxD5wLFFn9Vv68Fuw25DeWW7uoX053kUE2hlkCVU35GaG06hCUFkt02.vV25V853tz4Zgl5M3J6.P.fcnPd9bl1NXZhD80.OUdIwqehCZSsYk5XyfKKA0dcPwZKKu6y3YyIDZQOgnQHHHH7ZEi0SymquRGCJD1xBG0hwzW5Jet20m7SbAMc1KyyqzdMPH+EL9RR4X4YuhhprVshsL7g0ViVNhEvJVwJ7rf5RMNDSfp38mq0ZOedPaMnI.hmkD8G111UEBpIiR2B094YDc3gpTA4CnTkkqc4Yrqqtx3YjReweVMgHnVPPPnBQ95Mt3eexj0rS5fgS72iYyX.MvQsMAlzz56Rt1+90epuu08qIh7mQ.ABTw5EeTfJ4z.qX.1dDOK.fMBTtVPzqhq3R0B07XP+4Zs1y2xnqs1JlUWGqPwiM9xsYCkk0cKHLnwFW9vG2abhJhfZAAAgwHXlAHCXxLriKXN29KqSX0SyNK1vXZFVrFlZMFlUXhm57dt206ds+iS5Cdk+AhHa72sd+WWpx8aQhqvVntol7tfOMWwD7LJREOTy0Zqs5cA0kg.Kx3jKW9vpt5pXKECVqq3gSQ.fwMtwUFBp8Y5UrJEQPsfffPEhTmGSM.HRggrrQuV1XDVgX.vJS6USL.Svl.rIEhBfS4Tmmt4SYp2yhNyUd2Sd4K7Im3q+0O.9sO.vG5pJ45FwU2KJcMnJpOAy5HdV..aW1VeyyVntLJiJd+4c0UWdV3iVqOgPjzXAl82eE6bEQpwDW93PG5PkQan3ytFyrtZ20PDA0BBBBkAd0GQIPPyDr.g1l9Bv48Q9m.BR.FJvZDEL1Iqz6jHUGZl2ih06Kvrl1AFXRsz8jlzjFhHhw+ynW8lopiX8aAnxJn1116Bpq43hoythe8r81a2yhlJOKVdxEizXiUPA0iMgjtoN0oVFsAtjiPHUSHBpEDDDF0vsOEU7O4Z8YGm6fhawYiw0LF900dySbgKLJ.r7q+OeRBUXKT6cKn5mssRhqh47TYFKFfjeNOj2ssHsiS5H1fCVwVjuLFaVThczQGkdafwIDBpq1sPgfffvILvLCaFXXkAZaQKJLQTLQLcdfprgi3wRA0iEQEkwH7b63.G3.mnzlq3LRu8VwNWQ.0UoN1oRrXwJirhJUUHnl4RJGkl.QPsfffPYQp8ijdlNL+YDwW6g3pdg7UTKTqss8t+.We8iItuPwDdmuL.Ybp3KJwst0s58r+mscd21hzN.aqqNenoBQ34O+JX6kGSV7wKdwKtjeeBQbEKw1LVhHnVPPPXLlRO4cLJVGn3ZZJOixTwnhm8z7wEAmED0I2nHfvgC64yYyZVy5j9yYdkd5omJ2KDpvQKGW17l2bIuuLCuj3jp58IeQPsfffPYg+EjVpIuiQYzD.RVUFapSdtSGtx5xGZKKu6xGUCi.50TT.rBqd0q1ymG1wN1QIWZFFFmje9dTDhBoPpOmm8bpMZfet2HSTDMbosmDx06sR1lblKjx0UN7JhfZAAAgSBg.r7iKojZORdsCpjaWIXrRhpnVVyt4l8tf5icrpdAdDMlDRw774gEu3EW5myzmb4xGBvKt7QEeFO13F2n3C0BBBBB9DhhktkpFazv3FlAKVmOLWYCqeZeHZyOhuOdjhOrJMzip5YxskEc439TrHJ+E31nIZ.j5brPY72x+d4ct+6+9i+a9+8HLXu3xG4bOyU4krl6k2zjjMtwMVZUiTJMAAAAgS1fch8qNcG4mNAI+XImRWTAwUzv5peDT6msUHa76IO6pjHpmlx+BqrH6ou151ZqsJm36wH++esqcskz9QL.CxKBpGKZGhEpEDDDD7Ib5VExa8V4zeiOrjSN6fpXQ4A.EHnpZrP8I5BpKr8hKM1wN1QABYIE1l3JCtpXAnw1px45tmOk1TSM4qS+L7t5RlJ0X7ryie92R6kvZJg8jEp046idvNzkrA.7yKgDA0BBBBmLBgnI6+n382jgxBu12A4uMO0Brx5xGEJrtkImnKn1Kn7oNoEu3EWxZzC5iqMURBn7ifZxwbqo8EdiI77OeEKjGRvSQPiQohpzPS5htnD4xyB0dptsicrCU4HKVDTKHHHbxHDFrL1au12gBvQmg+BrIU9Y20OBp8y1dhIkjVI+pAO4NZGnpvB0ldzatUYc9Qk3+7B02PCAHeHGi7wAmAMTgORYeUh.AEH3yzQTNstqWpmDLJpfZJKWqOyX4g+pa4hEu3EmR0kRbry8gqPQWDAAAAgSZf0T4Hn1qVTqz8CZpxpp1zzTDT6e7rF4ibjcl3ZueEVqQ0QRGRWdY3ROa04ZZt4JVDsQwTuk59F2YO7zku8su8Y.3eQkLA.co3xG9BO0FN7gObYstMDA0BBBBmDhBb+rmCYdt8GkX68TLht2d6Mssy6gyYFLfkG23RB+jpj8i36iWovMPm+5V25V8rlgPglZHfRKlqqLzUEVnVoK7B5SA.CPPmiyd81audNSepi0PibF5EIPiN4YUh6M+ZQycIvfgFrSfp2i5DarwQR7rNyLTH+VNNyRkLTQ7PQTNombOM3lZpolTFXS1mWRZw8bedSDTKHHHbRHZl5k7nsCSW3MivgC6IKpELZzzDUjo3pBU9UZe+zOwIY+H993I7SPESy.qXEqvyVcMXvfM.3sAQwLm18BQnpCKTaanSqdjq6Wce1f..XmsPQZDxxpduVNjodhYNtCuNX2hglwQxp772bF3oaQpoloUahiueGDkMWTA0D4+nona67HG4Hdx..ACFrNEzfJw.ihHnVPPP3jPHENZotuABDnAOsc0Va8.NSqatzUwfyifKBLiRL6o4YFaRRIGmfqe4VHQA8u+8WmWOdAFJVad0IpIhRS.YcvnhN6DdEkNPBkUNVLN8aCR0Brt+MEALR3vHnNvD8Z4DnFdNpb7bPRO0sbhCKb2odUM01QwDVqXEN7gOr2F7rNXKo94BIIMyVisgcwWTh57ag5rsWrN9267s0TSM0l49jKBLht0idntbpe4XPAIudmaauKBpEDDDNIDsO8sRGKu47SCa6VJ11C.n35awfQBK9jKwyY1wUhPBFQg8S8yur4MuY+r4mPJn1O1gSQ.0zxjlfW2dqtO5BHFPUBt7gokcUgKeXxjMfqfs3Qr8BYwchgAQX+64kAi.y1qkyHGryyM.x0har7g0TWo84TtUtPVAm.CEqQ8Zsmrzd.SqY3uUgJk3YessQwWOG9L7+Q.H.qggNaw94CEnS4nGpKXnT9v8zRc+EDDDDNoCaXezLETUnNQH.D.LNZmGBJ6.S1KkgRom7Q67PICNedTbkFJXAzum13RjUu5UeBoHY+hNieOehrIFfewctbudbs5py0n.mYJq2CkDPffUGBpCRNVJO01PgtGl.ifDiZXM3C1846kxfYl5b2c7daTofQEXc3ZSnSuZg6TszqBDN1g5BAGW6dZPTl64Ud8YuDNcJ27MyGLyvlIvF1EHRjjfb3VHNG+racJX.f5TJr6suMDfwL8vwGrM9ahMXXDfRMpDk7Hmrcj6VjHnVPPP3jPN0kr3dr0VorT9oB5iyDADRQnui1Er1+gVfWJCNZz4+xOy1PsJi3wnWu3OsDFQqwhOsSuGezb7MISUxdhSpEeSDgPjF6+Ou0OiW1dlYiNewcttfYnvxqCnJpY0gf5PJqb55ItCLH6AfpQPhPCLig+ya8Z7RRQYfAFX7O6S73sVuh8dXAwGzvBmeONtbk+DqWmhPG+4mAFCFYwdY6OxKsqOXPhgxm4iIasFKdYmVQmMJlxkf57CAfZIBu5d5.vV+1J5wmYh6K7F5bO6FgHBkxi7hfZAAAgSBoFUM8BPIlRdFLn3qNe.GwBLRcwhwH.QnVnwNefG7R7RYD8O8rqwr6Cg5LR2aMcsuSt7gSMXXw.wfp6Rtw4AV6ZW6I0hj8NL.wnACEdx68dO8QNXOKrX6g0QFb0+oG5gU0YT3ARkOKWRPUU3C0QhFHm0C2AFj5.DhubDQP.Lw.J7zOxC0vHGt+h51GlO5SbcC1ygPSFFEHvcW5w6igZHvQrYxwRvodDyqOayfHF0anvKtkGG5i02GnXkQ3t5ZxO8l1zLqUofSzJw8X6TuKTz9PCBVAqont7AA8PDgLdOBCUdNuPDPMFDzQF.c9fa5iwLWvntRzAvbitksL8VYaTiJYcO0y6EKdWKBpEDDDJCNd8knSd9yu2XZNM+nLMABoHzFHdGYwEV8D2+8dQQd9NldgN9Qd0iN8e0W+qcgiSQHTFVpzsiob4CmZ.DQqwLm8Be0RpgUYnpW7cImEU7HMXX.ytNHdla9KtEl47tHuFXfAZa3GcyOTecrKTuged5Ht+zp0HTcMVUXg5VaodSSctBJdYi6fOMHflLHrumeq3na5QtGt.Y7yH64fy3m7U9p2bqF.FJFoJ4sT7g2bwDlvDFZbSrcDk0osvfK7rEvnVCCTSjAvA9g26E0We8M97tkLS7u4o+tu5ytUzX.J0uuf0KF.ZlgM.TyeFEe8RvJeslJbWjsMGv.+x+6usJVGc9H4STMybizQ55odfu82BiyPEOlf5e2u4309BDDDDphoH1xnBK9wKDNXjgrAgTSp11blQC2zg.iVBXfVGd.7K+nex8EdKOyU0YmclVD+nyN6rgHuzAupm5S8Y22.6cmXbAUwytKo2AqSGtTh+41+qESHJHzxLZ6.keqrfTwDIO12wZk4FJWQQDXTKAzdHCrie8COo+309I28f65.m9d26dqkYNHyb8QNVjYFqqvWOsoG+v+za+VpYJATndBfJvo4b8ThESX5ydbkofZOj677.SdNKxLVbQeo5xD4yx5ZVG2OpILg.J7vek67L6++9d17vc16rXlS3QGuvK7BgB+XO8a4Wsg+wcWaOGBiKXfrNOUJwu6bAQj83ZeJcDMkb2sWBWh0.MZOX.7a9AeGz8W668zC2Yuy59tu6KQafYVM3gO7TF3tene58ea2xaapFJTO4F8rIPTgKAlALYB0TeinkYLih6NGL0Gyo+PaguJ6Xo8VCXfZN7gvCese3yejssmCYdzAunN6ryFtu669L1+92eclGI7aY3mY2c8K9fW2D4izIZIfALH.24PK86fSVh45t5xJqvHHHHHb7IKdsq07Q+Te9nQ0nlZTwifGDkyvCVpDj.lbnfnmW8kU+m+8W8+2RN6Ugm8KbmZKPco.09tt06T8Ra4wQngG.sELHpUQHyt8XfrxE4tBHr.iAYFSXNy4fixM4RlMtwMhJVprqJlTE0EfHzjA.Ex.uvu4gm91dpm7YW74cdnuoMUvPg.rF+kGayn281AZ2fv3BnP9Szfto8irQCfn.UTKTq8nV0.0nMshmxNUTgFZfCIcEDFsFz.vLB9gewuv41zO4Gu2kt5Ugc+M9NHx.ChCbG2E9kO4VP6DioDJDTU3vt87Vwx9AOwKt8aoQXf.d7TqhXTuhP6gLvu8G7smSnG4g16os5yCa61+Z.rBO+s80wyu4sfddkcgoYnPqE75siKwnYcxH6A.hnYL0YOOM7PRaw1fOVpKwUlYOLnCFAIMlbHCbj8ua7MV6kO9kdtm+iLk4u.LWB3Xu7OG6Xm6D67I1BlfhwDBE.FjtfCBrPHBpEDDDF0w05LYkgAy4Ges.hH9Aur22CM3N296HnhR56zErxkLwUL9fJTqF3H+gsftepMqrY8TUjBFDgIanPs0DDAyiMjRoawz9VlYXxJLHoPiW1aNqDRwqUrwMtQ919+9YdXKciRsi01ntbugJUaWlKRNHq5UDlVMgvvlCg8+q1Dr.C.ETfQHEgoGxwxz4VvbpK1qrKK2xXfRTPs6Qz87exOWZbjlsLMiWqRULmNqeK6m2I.zR.BgLLvP6a2X6e2cAcb2BI.Q3TCpPiJmmkJUAbdkIc5q3gF36++bKimABQ4NyNlMjiuTq.NkPJD4XGB65G+ix558rBYf5HmAQ31NR8sdNBec7z4jBfIXBE5Waikthy3mPdHEu2VaS9n1Gq6DGcuZAeBLBnHLgPFnNMPOO0lQWO4VfMqghbFn3rBoPsJEBfzuVvYzdROddC3b8Wk3ShfZAAAgx.2Wo5IRzuQUQhfCKa0m2Crocr02QiAB5YKWA3zIUHBHnAgVTFNIlCWe1f3T5rwiYIuDcNpvv11Xom8p+0DQUTqTNZMk5oyqcdQodLXPZFvwxkJnQMF.sXXjHJw.fDK.wBelM2QPAN9+oAvhW6Z8z09TW5aUhqlQW9xMixe23sHedBl0vfHzHAzP7HeAywmXFl.HmE.bZwEZOY0U+SqW9p1g9FaBwhEIdYCT31SxzIiAwnAhPCJi3WinDOuSjquimg6bk05xH6xxjA5iILsUc9eKuzFZo8o0k0Q6NY46i2gp.PHhS79p3sL33VHwqwrclSZluQ7gZAAAgJFISIDUAFkNKlvEb9aoenvvZcFxfx+5xOsXxab+TzoyHNEqT4JrxYqy1mMSdrc80R28XHaMV7pO6aqzZQ4qdmyNe88kjLix.495pqegW45dM44SuEeg8yQL23zRscigCryfkT.IutG2RqEp1j+nxfy0Gajv5xd7ZS5mmy7pe45I0qd0q1NJCXy4Koqj44sj2QjdD.gAhaQTJdrsHcwzwimxUjA4APDE60s5y6tGxJeYuamyTIq8tu2xM7.5b8184c.cxelqAGwo1txp1.lILjsMps8ofdm8DeBuzFVvxWQmwz1wqcEeAOlXvVbx1ga8mHc7+wvcf+45TelOck8y6pz1BQPsfffPYR0nXYuPcKd1u5BOmUEcPKan4haaQfjQyfDel0IrxSVK7v7zYa1A..mEGY+VZXWWSQm6Uu9euuaLUP7xTRGeKK6xp3Qt3W6I8H.SpW28mD1TiDDZFXXMiVaqcPjebp3RHZL30qlDwAZno+ZLserGZdOVHoXajhX0wl2d7Fd2q8lFTSXDl78rY3t1J.buCO8ALmqsOaRtX9rgBgsYbYa3C7klwLlQQS63..su347pQ0TdjvW35d5vY7uQODA0BBBBiBTrIPsZTmDQj9McUq6l5mILrFoHzM2VrzsyeMq8jP.E.Lhuntb8tXGKDk7X6XAIfgYE511Fq4ueCWco6tG4yRqo+c1fymo5JHYFkAx95ZpcTO55VO4N5FLVM2G4+N3bGgwyMYJ2NUW8wF.CpYLuksrC485Uls8zqmdIZVTLlyJVwuIpscFG6hEeIxUMy6hOIOVN9gVN6U7JmxRW9u+vwhByLrrp6YpB8dJ1cFIxgOFm11k16ER82UNKEUFnOSKXWeyn1KdU2rWq+0tj400HDgnZcNFPd5j5bDk63cuajEJeGHJi+k6ialt0lHnVPPPXrBNo.hpEhdFK7atp2w5P2l1HJROYQmYGNolPKR82cr5bt6bp3SOKAaVgiZFC0Om4u2Y8I9.2W4zd7HEMpBHjKxVtUwt950iqIHzuF3TW4J2l+pMdYdUJcV14e9aYPMxJwn3WzELSERPq0vUj2ny4zLJAh325Fu92Uj5aE8aYCMWLGzIax58A4X+yuaqPvFDFRCzsMi26m9y9dm7jmbQSnKtLg4Muvug2xEEtWKa3mr9SghZQYWWIn0.5RbAIT87VcAAAgiiI45WOUKZTMZW5zos1ZK7httOzGOzbVDNZrXfSoi1rRE4rNm9.apBrcvwxZt1Wy87fSlXN0tcbrd8.V1HVsMg0da2vY6uo62qj9gjXNpeOBL6XUa+bMkPls2RmbWp5Qg6vx+QfhaSNslwPQiB6r709jj2ATwt9UuNmeOE2mZG1lQrFZBi6Mct2SoW+81JAvOL4y+b+CT8MiAsSssWXaeqx3tDlYnHUJw06zWIB1ZFCa5LoIo+bjS4jtEQK8VTSKaYG9Mcsa3c1qkFinykqWkr9l5OS78j66Fhag2731GYeufy0XKsBGwzBKbMW9V+J65O8C8ScmHhOsK6Rt9C6NaZd3NeM.rykUzQtW6CZMvHllHlsMRl03ydKSdUHok9csfuffffPYPhW8lg0kxseRV8IxtlY01Wesa7y7GBWWKnGKMLYUN6vxKKZJm1Z5BNRrnfRY+0LAKF3XV13f1Lt7O5G6Rabkqryxtwjy5S5PfJEKTGCveVj0oSV+c8lxeh0KGnpHVyzkTWzb1fPXSaDkIGqalmYuHSbhHC4dPXNyNAPLF3XVZbdqa8C0wv89iK45aArtao5qx0N8Is2Us10o6wRiQ7nUcyrN3dNHUeOmgy4wn1LFvzDwfB5w.GneQW26+mcZWva6acHSaLjlxokpUwcIqbcMMSKs6kYfhYBQz.GLlIp+TWPem9M7QW8m+y+488HC12La66Osks7gNloIr4QuyWLbdWTul1XHVAqR3czDHQPsfffP4i6JeOiNlh+uJ0p2ezBhH8AmXim+6+t9lOeW01HNRLSvwEUmtu6R40lnIVzRdQzMHngBCXwnaaBuiO8m8iNkO3Uroxtcfrc+Dm5S5VEG.dZgPkAwsps+DlwbkH5+Q442KEJd6wYgjQnsoNWbjXlN9fa7XKb5dIa9raq6eIcKrx.vB.G0zBAaaJXoumqbUKYIKojcGmbcuWBqBmGg8d3XZO62y5+j1SdZn2XVoMCNIhNF9VrtiHynrB8YYiIM04ggXJdLdNaR2hnobFtDDTRDwmyccGW6odwW58enXVXDsyLGkZSH+mmzwipOENjXZPthKcZmlLgdrrAM2EZdY+W20B8iqdjJKYIKI1kcq23phUWSNtsBJMG9gh+lM2kVolA52zFQpsArfUd1HlGubl4S.hfZAAAgwJnwpEQl+Y9ye9Qq+rW1x+P2027d6qtVvAhYgvZELiaQx7IbKwzCWjkqma2X1LgHZENTrX3ngpGq+e4ydsy3ZV+2XznM3ZEvDVBLuyL.WxVnt5gw1AoMLCrxa41Qu02B5JlEFgMJ38EoR5WGbbHBcbgVGwRiApqYr9u3scMglYaash0..J43LbMydxei22MdCGtaVgiXogYhHhS7EymONvtVlNrlwAhYgSeUWBNiq8ifHbEN8PlBDQ525231W+q6BVy24uZxnGKaDCd65IghGd+bb0BBwXE50lwdiZhws3kcn2424qMkllS6cWN08FVzb2564Ftw+kW0lwwrXXxHQ81utXGyDhw.GwRiv0z.V6W8afwuvETxOnKBpEDDDJaR2JnIiyC53dRbxspZ1V0DQV0+FW1UbMa5mdAi+bVcz+ZLSzuEiXrq+OWX2.wscmLzZ4tnfbrTklILnMvAhYB5TWj9ptq+8yu8Mr9+qQk5dAqao6msbIHNlHWKT6mqfZfxxkvctKJaK+liPTHWvU8VYAAfHrB7ha+T9P+v+2+bnYs.bnnlXXMhakTmI7Ned3apQyC.GAPlPgdhoQ+0zDtnq+i+QZbUm42YzsFmuYLojrRso0qeoKbce1O6Q1ulPeVbBKU6uilBZFXHafthYiS8sslCOua9y8onZCBy3qmfBeYLiyvdMZNlCHhzq5t9W2v69NtiMb3ZaBcFyBQzo9bdttOO2tBFPR+s20puQ0.8DyB+UKfy5C7A+AK4KciytkS4TNZIWgSglV+kbG+s2vM9c5zlQelZXE+7Jib+d.WbGXmJ96jzLgdhYgtpsIr9+i+y8D7zV30GNXPX5wSq5LNOIYJQAAAgRjgICDAFPwDnTruTxDRb1B5hPDpwXrqN5WhGyk+0LysD9devO4O4N+52xwNbmnQCBMXnPHkAB.c7rlWJ9OdJGCMPbeyDvDJDiYLjsFCYYCt9Vvptp08jmxG8purlZs0iUN00XJEFgHLHB.K1MzlkKTItlDgXDiT9VPcDfXQHBA47kjORmQfAFNdczOXY.LLHLHTwiWxNhUy+zv6Dx4hp7iAx7U98D..1DgFl3DOHy7Y8Nuq6b0O1Fu8Gb2+wszv3IfFCF.AAPMTbYUwuuHs6IhaAVSPHhEiiYaifSr8gee2wW7hZdUq3w8UkIN464ujtWR5Wmz.HBSvrDd94yucUB..GXRRDEDUq0Vas28u+8Oiqaxe8e12+S8ouvHCGFMEv.0EOkUG.T7DaT5nYmx084fiEyDgYCbA+cWyW80cier+YhHqvaZKmaDRslvv.LQNB9xoajj78ICBEhVl1DM9y5e6v6oqGbaeou7OeaO5ibVsnzndU.TiAPMjALhOfN2wkj9PScBkjNVjFHFHDiILjoIBqIL8kt7Nd6ehO7au4y60+h3F9mJq5Zl0al4Mrg1lj426y7ou19hDFiyPg5CPHHXD.p3WKRdWXbmxKgO6GQynWSKz5rm+Pa3y+4t75eimwuiHh+i2w23KODE.CBCnXuD9Kcd9KhVDTKHHHTxzqAg8E0DI6.GNVMx02FcsfTJ95XXkBsEnJVQcbHhhBfas6t69NG9W93WwS8Kdvasimc6SpIXhFIBMaXfZHffYXkLGanovHZaLrlQ+ZMBCEZadK.myZdauz7u7K98G7TZ+o8dxRI+LXHENrlvfQsPPVm846bb9ePEg9CZLheKqvFAhseSKz.yIMLXAJOShQDhvfA8W2rCGPgdXBwFwLwwiRzodbY0oVdwibJG0PUFVnNUA1oKE1UTRJKrTF.OFybqugGYyu8G969+7ce4s+rMMNRiVUDpSoPv3oUaWOskie+vfZF8YyHZCsXt5q3JtoleWW3Wo44OeeGwUbI4yetU1rudm1yi.nekAFNPoIDcFyXFCyLewWyh94W7u6qdm+3s9vaptIv1nEEPCJCTqRAizhMwDhxDhn0nOsE5EJLskeluz593W+5Z5Md5OOtoON..rLze4iYDXM7Hln1BUARo8Ekz3nJCffkTSIMZZNs2My7a3u4E1vr+S2y884+yOzCcUpvCfVUZzfhPCDgPwOko.ChL.yNy8lY712fZF8yLranIrj25E+89aun0bqsbwm8qLZ7bdtHtn5q6ZN8G3m+h+u26Ocy268TWMCEFsn.ZQYfZTN2A5dk1FJLjsMBq0nOlPvI0dem264J+.K45d++BhnDQhuHF3u1CiYFaDKTTwzo77GPMU0y9nfffPUMg+0+dlhkZG1bR8H44mTPBXRiGMbFK93p2+xLSG8O8mZZjs8Jy4U+K+kkz6Ae0y8Eegs+FCBd9JBAIhRLsqZhvLm47PSs29tVvxWwudBqdUOtdFs7DMzVacMZ1AazcsO1ZeG.vN9z4x.jh.qYmeZqcLiNHmrSGyfL.FIn52Ng2747V7SY0yu8I1V8V7YvVos5sx35qN9OUfTDP.CDXlSE0rfY44q0Q6X+r0dO.fkFbthGt449JtFCyldqmcnhc7ela+qw+ku6+MlQv.wS8xtVgK2BpQ7oFemiXgOxqrirZGLyp9d7mal64A+4Wd26piqb263YOy.fghhaUZx4XbJybt6cpycde6YthU7Km5GbcOWom7dRRhm+xpRgB97WfYOSTy7lQY87GyrQrWo6WW3e6VtzmcyO1a+Ue4NVQeGsakA6z1AbZ+VfNzbWxx+Iy8LV5uYZW5ZdplVwBNZlOCvLSG8Qex2Zs152AXLeVy0BBw.ivjh6WaidIE5EL5mT7.L3AzVAFJVM5gvJl7yzVaKJb4zVxQaKX3G7WMmt21Kdluz119ELPmG5rN1Q6ddDR11baegpqgNl9bWvCOo4O2mbNm1xdlVeuW19GMt15y5qQz8dv41+u6Iuzm+w17auimc6uAygGTQtqoBvHpFGdFyZd+rIOu48am+aXU+9Ic0WR245cQCryCNQ0916GF15UwZLaP73AS0RJDL+2WE28hFCayBBBBBm.Byra.YM0ve.WorNkPoStETWHbhOu6LpcNETmILyTGczQnZqsVUvfAUgCG1ZdyadlUl3Kd0CriyGa..piN5PMu4MOa.Xehxy.waez8e+2Os10tV..c0Zaystt4MuY0pW8piOF+JecUb4CAAAAgxhSzEKchGUt3QPbgKkrabb7Jwa29II9cbEj2F8UUAT5S8xXFRT9PPPPPPPPPPnLPDTKHHHHHHHHHTFHBpEDDDDDDDDDJCDA0BBBBBBBBBBkAhfZAAAAAAAAAgx.QPsfffffffffPYfHnVPPPPPPPPPnLPDTKHHHHHHHHHTFHBpEDDDDDDDDDJCDA0BBBBBBBBBBkAhfZAAAAAAAAAgx.QPsfffffffffPYfHnVPPPPPPPPPnLPDTKHHHHHHHHHTFHBpEDDDDDNIBhAHxQ.fiH.c7+kNJv.fGSqaBBGuhHnVPPPPPPPPPnLHvq0U.AAAAAAgwdRZS5baaMMX.PiQ0FAgiuQrPsfffffffffPYfHnVPPPPP3jHXBf8jqQqfXgZAAugHnVPPPPP3jFjt8EDpDHOYIHHHHHbRGhkmEDFMQVThBBBBBBmDByDnhnqlYBRnySPn3HBpEDDDDDNIBl439PM6AeolglADKZKHTXDA0BBBBBBmDgl0XXyQRD17b88yL+bhsOkT.iffPt4+Ofy0vGAULLhbB....PRE4DQtJDXBB" ],
									"embed" : 1,
									"forceaspect" : 1,
									"id" : "obj-3",
									"maxclass" : "fpic",
									"numinlets" : 1,
									"numoutlets" : 1,
									"outlettype" : [ "jit_matrix" ],
									"patching_rect" : [ 47.0, 580.129851114684016, 222.0, 130.624309392265189 ],
									"pic" : "/Users/chemla/Desktop/ircam_tp.png"
								}

							}
, 							{
								"box" : 								{
									"fontsize" : 40.0,
									"id" : "obj-11",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 47.0, 372.895263671875, 818.0, 51.0 ],
									"text" : "http://www.github.com/acids-ircam/vschaos2"
								}

							}
, 							{
								"box" : 								{
									"fontsize" : 60.0,
									"id" : "obj-2",
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 47.0, 14.0, 714.0, 74.0 ],
									"text" : "↑ explore the tabs above!"
								}

							}
, 							{
								"box" : 								{
									"fontsize" : 30.0,
									"id" : "obj-5",
									"linecount" : 2,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 47.0, 278.954269409179688, 1096.0, 74.0 ],
									"text" : "vschaos is a light ML tool for unsupervised / semi-supervised spectral generation. It can be used for real-time exploration / transfer and audio analysis."
								}

							}
, 							{
								"box" : 								{
									"fontface" : 2,
									"fontsize" : 40.0,
									"id" : "obj-4",
									"linecount" : 2,
									"maxclass" : "comment",
									"numinlets" : 1,
									"numoutlets" : 0,
									"patching_rect" : [ 599.0, 106.0, 688.0, 96.0 ],
									"text" : "A variational autoencoder for spectral generation"
								}

							}
 ],
						"lines" : [  ]
					}
,
					"patching_rect" : [ 23.0, 99.0, 85.0, 22.0 ],
					"saved_object_attributes" : 					{
						"description" : "",
						"digest" : "",
						"globalpatchername" : "",
						"tags" : ""
					}
,
					"text" : "p presentation"
				}

			}
 ],
		"lines" : [  ],
		"parameters" : 		{
			"obj-10::obj-10" : [ "gain~[5]", "gain~[3]", 0 ],
			"obj-11::obj-10::obj-12" : [ "scale[2]", "scale", 0 ],
			"obj-11::obj-10::obj-2" : [ "bias[3]", "bias", 0 ],
			"obj-11::obj-10::obj-40" : [ "live.slider[3]", "freq", 0 ],
			"obj-11::obj-10::obj-9" : [ "tab[6]", "tab[3]", 0 ],
			"obj-11::obj-12::obj-12" : [ "scale[3]", "scale", 0 ],
			"obj-11::obj-12::obj-2" : [ "bias[4]", "bias", 0 ],
			"obj-11::obj-12::obj-40" : [ "live.slider[4]", "freq", 0 ],
			"obj-11::obj-12::obj-9" : [ "tab[7]", "tab[3]", 0 ],
			"obj-11::obj-14" : [ "gain~[3]", "gain~[3]", 0 ],
			"obj-11::obj-18::obj-12" : [ "scale[9]", "scale", 0 ],
			"obj-11::obj-18::obj-2" : [ "bias[5]", "bias", 0 ],
			"obj-11::obj-18::obj-40" : [ "live.slider[8]", "freq", 0 ],
			"obj-11::obj-18::obj-9" : [ "tab[8]", "tab[3]", 0 ],
			"obj-11::obj-19::obj-12" : [ "scale[10]", "scale", 0 ],
			"obj-11::obj-19::obj-2" : [ "bias[6]", "bias", 0 ],
			"obj-11::obj-19::obj-40" : [ "live.slider[9]", "freq", 0 ],
			"obj-11::obj-19::obj-9" : [ "tab[9]", "tab[3]", 0 ],
			"obj-11::obj-1::obj-12" : [ "scale[1]", "scale", 0 ],
			"obj-11::obj-1::obj-2" : [ "bias[1]", "bias", 0 ],
			"obj-11::obj-1::obj-40" : [ "live.slider[1]", "freq", 0 ],
			"obj-11::obj-1::obj-9" : [ "tab[4]", "tab[3]", 0 ],
			"obj-11::obj-20::obj-12" : [ "scale[11]", "scale", 0 ],
			"obj-11::obj-20::obj-2" : [ "bias[7]", "bias", 0 ],
			"obj-11::obj-20::obj-40" : [ "live.slider[10]", "freq", 0 ],
			"obj-11::obj-20::obj-9" : [ "tab[10]", "tab[3]", 0 ],
			"obj-11::obj-5::obj-12" : [ "scale[7]", "scale", 0 ],
			"obj-11::obj-5::obj-2" : [ "bias", "bias", 0 ],
			"obj-11::obj-5::obj-40" : [ "live.slider[7]", "freq", 0 ],
			"obj-11::obj-5::obj-9" : [ "tab[3]", "tab[3]", 0 ],
			"obj-11::obj-9::obj-12" : [ "scale[8]", "scale", 0 ],
			"obj-11::obj-9::obj-2" : [ "bias[2]", "bias", 0 ],
			"obj-11::obj-9::obj-40" : [ "live.slider[2]", "freq", 0 ],
			"obj-11::obj-9::obj-9" : [ "tab[5]", "tab[3]", 0 ],
			"obj-1::obj-21" : [ "gain~[7]", "gain~[3]", 0 ],
			"obj-1::obj-9" : [ "gain~[6]", "gain~[3]", 0 ],
			"obj-2::obj-14" : [ "gain~[4]", "gain~[3]", 0 ],
			"parameterbanks" : 			{

			}
,
			"parameter_overrides" : 			{
				"obj-11::obj-10::obj-12" : 				{
					"parameter_longname" : "scale[2]"
				}
,
				"obj-11::obj-10::obj-2" : 				{
					"parameter_longname" : "bias[3]"
				}
,
				"obj-11::obj-10::obj-40" : 				{
					"parameter_longname" : "live.slider[3]"
				}
,
				"obj-11::obj-12::obj-12" : 				{
					"parameter_longname" : "scale[3]"
				}
,
				"obj-11::obj-12::obj-2" : 				{
					"parameter_longname" : "bias[4]"
				}
,
				"obj-11::obj-12::obj-40" : 				{
					"parameter_longname" : "live.slider[4]"
				}
,
				"obj-11::obj-18::obj-12" : 				{
					"parameter_longname" : "scale[9]"
				}
,
				"obj-11::obj-18::obj-2" : 				{
					"parameter_longname" : "bias[5]"
				}
,
				"obj-11::obj-18::obj-40" : 				{
					"parameter_longname" : "live.slider[8]"
				}
,
				"obj-11::obj-19::obj-12" : 				{
					"parameter_longname" : "scale[10]"
				}
,
				"obj-11::obj-19::obj-2" : 				{
					"parameter_longname" : "bias[6]"
				}
,
				"obj-11::obj-19::obj-40" : 				{
					"parameter_longname" : "live.slider[9]"
				}
,
				"obj-11::obj-1::obj-12" : 				{
					"parameter_longname" : "scale[1]"
				}
,
				"obj-11::obj-1::obj-2" : 				{
					"parameter_longname" : "bias[1]"
				}
,
				"obj-11::obj-1::obj-40" : 				{
					"parameter_longname" : "live.slider[1]"
				}
,
				"obj-11::obj-20::obj-12" : 				{
					"parameter_longname" : "scale[11]"
				}
,
				"obj-11::obj-20::obj-2" : 				{
					"parameter_longname" : "bias[7]"
				}
,
				"obj-11::obj-20::obj-40" : 				{
					"parameter_longname" : "live.slider[10]"
				}
,
				"obj-11::obj-9::obj-12" : 				{
					"parameter_longname" : "scale[8]"
				}
,
				"obj-11::obj-9::obj-2" : 				{
					"parameter_longname" : "bias[2]"
				}
,
				"obj-11::obj-9::obj-40" : 				{
					"parameter_longname" : "live.slider[2]"
				}

			}
,
			"inherited_shortname" : 1
		}
,
		"parameter_map" : 		{
			"midi" : 			{
				"live.slider[7]" : 				{
					"srcname" : "16.ctrl.0.chan.midi",
					"min" : 1.0,
					"max" : 30.0,
					"flags" : 2
				}
,
				"scale[7]" : 				{
					"srcname" : "17.ctrl.0.chan.midi",
					"min" : 0.1,
					"max" : 5.0,
					"flags" : 2
				}
,
				"live.slider[1]" : 				{
					"srcname" : "20.ctrl.0.chan.midi",
					"min" : 1.0,
					"max" : 30.0,
					"flags" : 2
				}
,
				"scale[1]" : 				{
					"srcname" : "21.ctrl.0.chan.midi",
					"min" : 0.1,
					"max" : 5.0,
					"flags" : 2
				}
,
				"bias[1]" : 				{
					"srcname" : "23.ctrl.0.chan.midi",
					"min" : 0.1,
					"max" : 5.0,
					"flags" : 2
				}
,
				"live.slider[2]" : 				{
					"srcname" : "24.ctrl.0.chan.midi",
					"min" : 1.0,
					"max" : 30.0,
					"flags" : 2
				}
,
				"scale[8]" : 				{
					"srcname" : "25.ctrl.0.chan.midi",
					"min" : 0.1,
					"max" : 5.0,
					"flags" : 2
				}
,
				"bias[2]" : 				{
					"srcname" : "27.ctrl.0.chan.midi",
					"min" : 0.0,
					"max" : 5.0,
					"flags" : 2
				}
,
				"live.slider[8]" : 				{
					"srcname" : "28.ctrl.0.chan.midi",
					"min" : 1.0,
					"max" : 30.0,
					"flags" : 2
				}
,
				"scale[9]" : 				{
					"srcname" : "29.ctrl.0.chan.midi",
					"min" : 0.1,
					"max" : 5.0,
					"flags" : 2
				}
,
				"tab" : 				{
					"srcname" : "30.ctrl.0.chan.midi",
					"min" : 0.0,
					"max" : 5.0,
					"flags" : 2
				}
,
				"bias[3]" : 				{
					"srcname" : "31.ctrl.0.chan.midi",
					"min" : 0.0,
					"max" : 5.0,
					"flags" : 2
				}
,
				"tab[1]" : 				{
					"srcname" : "26.ctrl.0.chan.midi",
					"min" : 0.0,
					"max" : 5.0,
					"flags" : 2
				}
,
				"tab[2]" : 				{
					"srcname" : "22.ctrl.0.chan.midi",
					"min" : 0.0,
					"max" : 5.0,
					"flags" : 2
				}
,
				"tab[3]" : 				{
					"srcname" : "18.ctrl.0.chan.midi",
					"min" : 0.0,
					"max" : 5.0,
					"flags" : 2
				}
,
				"tab[4]" : 				{
					"srcname" : "48.ctrl.0.chan.midi",
					"min" : 0.0,
					"max" : 5.0,
					"flags" : 2
				}
,
				"live.slider[3]" : 				{
					"srcname" : "46.ctrl.0.chan.midi",
					"min" : 1.0,
					"max" : 30.0,
					"flags" : 2
				}
,
				"scale[2]" : 				{
					"srcname" : "47.ctrl.0.chan.midi",
					"min" : 0.1,
					"max" : 5.0,
					"flags" : 2
				}
,
				"bias[4]" : 				{
					"srcname" : "49.ctrl.0.chan.midi",
					"min" : 0.0,
					"max" : 5.0,
					"flags" : 2
				}
,
				"tab[5]" : 				{
					"srcname" : "52.ctrl.0.chan.midi",
					"min" : 0.0,
					"max" : 5.0,
					"flags" : 2
				}
,
				"live.slider[4]" : 				{
					"srcname" : "50.ctrl.0.chan.midi",
					"min" : 1.0,
					"max" : 30.0,
					"flags" : 2
				}
,
				"scale[3]" : 				{
					"srcname" : "51.ctrl.0.chan.midi",
					"min" : 0.1,
					"max" : 5.0,
					"flags" : 2
				}
,
				"tab[6]" : 				{
					"srcname" : "60.ctrl.0.chan.midi",
					"min" : 0.0,
					"max" : 5.0,
					"flags" : 2
				}
,
				"bias[8]" : 				{
					"srcname" : "61.ctrl.0.chan.midi",
					"min" : 0.0,
					"max" : 5.0,
					"flags" : 2
				}
,
				"tab[7]" : 				{
					"srcname" : "56.ctrl.0.chan.midi",
					"min" : 0.0,
					"max" : 5.0,
					"flags" : 2
				}
,
				"bias[6]" : 				{
					"srcname" : "57.ctrl.0.chan.midi",
					"min" : 0.0,
					"max" : 5.0,
					"flags" : 2
				}
,
				"bias[5]" : 				{
					"srcname" : "53.ctrl.0.chan.midi",
					"min" : 0.0,
					"max" : 5.0,
					"flags" : 2
				}
,
				"gain~[3]" : 				{
					"srcname" : "62.ctrl.0.chan.midi",
					"min" : 0.0,
					"max" : 130.0,
					"flags" : 2
				}
,
				"gain~[4]" : 				{
					"srcname" : "62.ctrl.0.chan.midi",
					"min" : 130.0,
					"max" : 1.0,
					"flags" : 2
				}
,
				"bias" : 				{
					"srcname" : "19.ctrl.0.chan.midi",
					"min" : 0.0,
					"max" : 2.0,
					"flags" : 2
				}
,
				"live.slider[5]" : 				{
					"srcname" : "54.ctrl.0.chan.midi",
					"min" : 1.0,
					"max" : 30.0,
					"flags" : 2
				}
,
				"scale[10]" : 				{
					"srcname" : "55.ctrl.0.chan.midi",
					"min" : 0.1,
					"max" : 5.0,
					"flags" : 2
				}
,
				"live.slider[9]" : 				{
					"srcname" : "58.ctrl.0.chan.midi",
					"min" : 1.0,
					"max" : 30.0,
					"flags" : 2
				}
,
				"scale[11]" : 				{
					"srcname" : "59.ctrl.0.chan.midi",
					"min" : 0.1,
					"max" : 5.0,
					"flags" : 2
				}

			}

		}
,
		"dependency_cache" : [ 			{
				"name" : "_control.maxpat",
				"bootpath" : "~/Dropbox/code/vschaos2/patches",
				"patcherrelativepath" : ".",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "acids_white_bg.png",
				"bootpath" : "~/Dropbox/code/vschaos2",
				"patcherrelativepath" : "..",
				"type" : "PNG",
				"implicit" : 1
			}
, 			{
				"name" : "cello-f2.aif",
				"bootpath" : "C74:/media/msp",
				"type" : "AIFF",
				"implicit" : 1
			}
, 			{
				"name" : "horn.wav",
				"bootpath" : "~/Dropbox/code/nn_tilde/src/externals",
				"patcherrelativepath" : "../../nn_tilde/src/externals",
				"type" : "WAVE",
				"implicit" : 1
			}
, 			{
				"name" : "logo.png",
				"bootpath" : "~/Dropbox/code/vschaos2/assets",
				"patcherrelativepath" : "../assets",
				"type" : "PNG",
				"implicit" : 1
			}
, 			{
				"name" : "mcs.nn~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "nn~.mxo",
				"type" : "iLaX"
			}
, 			{
				"name" : "talk.aiff",
				"bootpath" : "C74:/media/jitter",
				"type" : "AIFF",
				"implicit" : 1
			}
, 			{
				"name" : "thru.maxpat",
				"bootpath" : "C74:/patchers/m4l/Pluggo for Live resources/patches",
				"type" : "JSON",
				"implicit" : 1
			}
, 			{
				"name" : "vibes-a1.aif",
				"bootpath" : "C74:/media/msp",
				"type" : "AIFF",
				"implicit" : 1
			}
 ],
		"autosave" : 0
	}

}
