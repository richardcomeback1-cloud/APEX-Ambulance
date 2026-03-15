Cfg = {}
Cfg.Animation = {
    [1] = {     -- Id จาก cfg.Hold > Source > Menu > Category > List
        Name = "แบก",
        Source = {
            TaskAnim = {
                Dict = "missfinale_c2mcs_1",
                Anim = "fin_c2_mcs_1_camman",
                BlendInSpeed = 8.0,
                BlendOutSpeed = 8.0,
                Duration = -1,
                Flag = 49,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            }
        },
        Target = {
            TaskAnim = {
                Dict = "nm",
                Anim = "firemans_carry",
                BlendInSpeed = 8.0,
                BlendOutSpeed = -8.0,
                Duration = -1,
                Flag = 33,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            },
            AttachEntity = {
                Bone = 0,
                xPos = 0.27,
                yPos = 0.15,
                zPos = 0.63,
                xRot = 0.5,
                yRot = 0.5,
                zRot = 0.0,
                P9 = false,
                UseSoftPinning = false,
                Collision = false,
                IsPed = false,
                VertexIndex = 2,
                FixedRot = false
            }
        },
    },
    [2] = {
        Name = "อุ้ม",
        Source = {
            TaskAnim = {
                Dict = "anim@heists@box_carry@",
                Anim = "idle",
                BlendInSpeed = 8.0,
                BlendOutSpeed = 8.0,
                Duration = -1,
                Flag = 50,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            }
        },
        Target = {
            TaskAnim = {
                Dict = "amb@code_human_in_car_idles@generic@ps@base",
                Anim = "base",
                BlendInSpeed = 8.0,
                BlendOutSpeed = -8,
                Duration = -1,
                Flag = 33,
                PlaybackRate = 0,
                X = 0,
                Y = 40,
                Z = 0
            },
            AttachEntity = {
                Bone = 9816,
                xPos = 0.015,
                yPos = 0.38,
                zPos = 0.11,
                xRot = 0.9,
                yRot = 0.30,
                zRot = 90.0,
                P9 = false,
                UseSoftPinning = false,
                Collision = false,
                IsPed = false,
                VertexIndex = 2,
                FixedRot = false
            }
        }
    },
    [3] = {
        Name = "ขี่หลัง",
        Source = {
            TaskAnim = {
                Dict = "anim@arena@celeb@flat@paired@no_props@",
                Anim = "piggyback_c_player_a",
                BlendInSpeed = 8.0,
                BlendOutSpeed = -8.0,
                Duration = -1,
                Flag = 49,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            }
        },
        Target = {
            TaskAnim = {
                Dict = "anim@arena@celeb@flat@paired@no_props@",
                Anim = "piggyback_c_player_b",
                BlendInSpeed = 8.0,
                BlendOutSpeed = -8.0,
                Duration = -1,
                Flag = 33,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            },
            AttachEntity = {
                Bone = 0,
                xPos = 0.0,
                yPos = -0.07,
                zPos = 0.45,
                xRot = 0.9,
                yRot = 0.5,
                zRot = 0.5,
                P9 = false,
                UseSoftPinning = false,
                Collision = false,
                IsPed = false,
                VertexIndex = 2,
                FixedRot = false
            }
        }
    },
    [4] = {
        Name = "ลูกลิง",
        Source = {
            TaskAnim = {
                Dict = "move_m@hiking",
                Anim = "idle",
                BlendInSpeed = 8.0,
                BlendOutSpeed = 8.0,
                Duration = -1,
                Flag = 49,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            }
        },
        Target = {
            TaskAnim = {
                Dict = "amb@prop_human_seat_computer@male@react_shock",
                Anim = "right",
                BlendInSpeed = 8.0,
                BlendOutSpeed = 8.0,
                Duration = -1,
                Flag = 1,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            },
            AttachEntity = {
                Bone = 9816,
                xPos = 0.0,
                yPos = -0.30,
                zPos = 0.05,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0,
                P9 = false,
                UseSoftPinning = false,
                Collision = false,
                IsPed = false,
                VertexIndex = 2,
                FixedRot = false
            }
        }
    },
    ------------------------------------------------------------------------------------
    [5] = {
        Name = "อุ้มแบบคิมิโน้โตะ",
        Source = {
            TaskAnim = {
                Dict = "anim@heists@box_carry@",
                Anim = "idle",
                BlendInSpeed = 8.0,
                BlendOutSpeed = 8.0,
                Duration = -1,
                Flag = 50,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            }
        },
        Target = {
            TaskAnim = {
                Dict = "penguin@update@v1",
                Anim = "penguin_carry_f",
                BlendInSpeed = 8.0,
                BlendOutSpeed = -8.0,
                Duration = -1,
                Flag = 33,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            },
            AttachEntity = {
                Bone = 9816,
                xPos = 0.0,
                yPos = -0.0,
                zPos = 0.0,
                xRot = 0.9,
                yRot = 0.5,
                zRot = 180.0,
                P9 = false,
                UseSoftPinning = false,
                Collision = false,
                IsPed = false,
                VertexIndex = 2,
                FixedRot = false
            }
        }
    },
    [6] = {
        Name = "อุ้มเจ้าสาว (เดินไม่ได้)",
        Source = {
            TaskAnim = {
                Dict = "penguin@update@v1",
                Anim = "penguin_carry_m",
                BlendInSpeed = 8.0,
                BlendOutSpeed = 8.0,
                Duration = -1,
                Flag = 1,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            }
        },
        Target = {
            TaskAnim = {
                Dict = "penguin@update@v1",
                Anim = "penguin_carry_f",
                BlendInSpeed = 8.0,
                BlendOutSpeed = -8.0,
                Duration = -1,
                Flag = 33,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            },
            AttachEntity = {
                Bone = 9816,
                xPos = 0.0,
                yPos = -0.0,
                zPos = 0.0,
                xRot = 0.9,
                yRot = 0.5,
                zRot = 180.0,
                P9 = false,
                UseSoftPinning = false,
                Collision = false,
                IsPed = false,
                VertexIndex = 2,
                FixedRot = false
            }
        }
    },
    [7] = {
        Name = "ขี่คอไหว้ (เดินไม่ได้)",
        Source = {
            TaskAnim = {
                Dict = "penguin_mppos@custom@v5",
                Anim = "penguin_mppos_pose10_v5",
                BlendInSpeed = 8.0,
                BlendOutSpeed = 8.0,
                Duration = -1,
                Flag = 1,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            }
        },
        Target = {
            TaskAnim = {
                Dict = "penguin_mppos@custom@v5",
                Anim = "penguin_mppos_pose9_v5",
                BlendInSpeed = 8.0,
                BlendOutSpeed = -8.0,
                Duration = -1,
                Flag = 1,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            },
            AttachEntity = {
                Bone = 9816,
                xPos = 0.0,
                yPos = -0.18,
                zPos = 0.7,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0,
                P9 = false,
                UseSoftPinning = false,
                Collision = false,
                IsPed = false,
                VertexIndex = 2,
                FixedRot = false
            }
        }
    },
    [8] = {
        Name = "ขี่คอไหว้ (เดินได้)",
        Source = {
            TaskAnim = {
                Dict = "penguin_mppos@custom@v5",
                Anim = "penguin_mppos_pose10_v5",
                BlendInSpeed = 8.0,
                BlendOutSpeed = 8.0,
                Duration = -1,
                Flag = 49,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            }
        },
        Target = {
            TaskAnim = {
                Dict = "penguin_mppos@custom@v5",
                Anim = "penguin_mppos_pose9_v5",
                BlendInSpeed = 8.0,
                BlendOutSpeed = -8.0,
                Duration = -1,
                Flag = 1,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            },
            AttachEntity = {
                Bone = 9816,
                xPos = 0.0,
                yPos = -0.18,
                zPos = 0.7,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0,
                P9 = false,
                UseSoftPinning = false,
                Collision = false,
                IsPed = false,
                VertexIndex = 2,
                FixedRot = false
            }
        }
    },
    [9] = {
        Name = "นั่งซ้อนระหว่างขา",
        Source = {
            TaskAnim = {
                Dict = "penguin@mppos@custom@v7",
                Anim = "penguin_mppos_pose6_v7",
                BlendInSpeed = 8.0,
                BlendOutSpeed = 8.0,
                Duration = -1,
                Flag = 1,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            }
        },
        Target = {
            TaskAnim = {
                Dict = "penguin@mppos@custom@v7",
                Anim = "penguin_mppos_pose7_v7",
                BlendInSpeed = 8.0,
                BlendOutSpeed = -8.0,
                Duration = -1,
                Flag = 1,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            },
            AttachEntity = {
                Bone = 9816,
                xPos = 0.0,
                yPos = 0.0,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0,
                P9 = false,
                UseSoftPinning = false,
                Collision = false,
                IsPed = false,
                VertexIndex = 2,
                FixedRot = false
            }
        }
    },
    [10] = {
        Name = "ควงแขนทำหัวใจ",
        Source = {
            TaskAnim = {
                Dict = "penguin@mppos@custom@v8",
                Anim = "penguin_mppos_p7_duo1",
                BlendInSpeed = 8.0,
                BlendOutSpeed = 8.0,
                Duration = -1,
                Flag = 1,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            }
        },
        Target = {
            TaskAnim = {
                Dict = "penguin@mppos@custom@v8",
                Anim = "penguin_mppos_p8_duo1",
                BlendInSpeed = 8.0,
                BlendOutSpeed = -8.0,
                Duration = -1,
                Flag = 1,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            },
            AttachEntity = {
                Bone = 9816,
                xPos = -0.4,
                yPos = 0.0,
                zPos = -0.01,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0,
                P9 = false,
                UseSoftPinning = false,
                Collision = false,
                IsPed = false,
                VertexIndex = 2,
                FixedRot = false
            }
        }
    },
    [11] = {
        Name = "อุ้มขึ้นบ่า(เดินไม่ได้)",
        Source = {
            TaskAnim = {
                Dict = "penguin@mppos@custom@v8",
                Anim = "penguin_mppos_P9_duo2",
                BlendInSpeed = 8.0,
                BlendOutSpeed = 8.0,
                Duration = -1,
                Flag = 1,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            }
        },
        Target = {
            TaskAnim = {
                Dict = "penguin@mppos@custom@v8",
                Anim = "penguin_mppos_p10_duo2",
                BlendInSpeed = 8.0,
                BlendOutSpeed = -8.0,
                Duration = -1,
                Flag = 1,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            },
            AttachEntity = {
                Bone = 9816,
                xPos = 0.45,
                yPos = 0.0,
                zPos = -0.01,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0,
                P9 = false,
                UseSoftPinning = false,
                Collision = false,
                IsPed = false,
                VertexIndex = 2,
                FixedRot = false
            }
        }
    },
    [12] = {
        Name = "อุ้มปั่นๆ",
        Source = {
            TaskAnim = {
                Dict = "penguin@mppos@custom@v8",
                Anim = "penguin_mppos_p12_duo3",
                BlendInSpeed = 8.0,
                BlendOutSpeed = 8.0,
                Duration = -1,
                Flag = 50,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            }
        },
        Target = {
            TaskAnim = {
                Dict = "penguin@mppos@custom@v8",
                Anim = "penguin_mppos_p11_duo3",
                BlendInSpeed = 8.0,
                BlendOutSpeed = -8.0,
                Duration = -1,
                Flag = 1,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            },
            AttachEntity = {
                Bone = 9816,
                xPos = 0.0,
                yPos = 0.50,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0,
                P9 = false,
                UseSoftPinning = false,
                Collision = false,
                IsPed = false,
                VertexIndex = 2,
                FixedRot = false
            }
        }
    },
    [13] = {
        Name = "อุ้มปั่นๆ(เดินไม่ได้)",
        Source = {
            TaskAnim = {
                Dict = "penguin@mppos@custom@v8",
                Anim = "penguin_mppos_p12_duo3",
                BlendInSpeed = 8.0,
                BlendOutSpeed = 8.0,
                Duration = -1,
                Flag = 1,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            }
        },
        Target = {
            TaskAnim = {
                Dict = "penguin@mppos@custom@v8",
                Anim = "penguin_mppos_p11_duo3",
                BlendInSpeed = 8.0,
                BlendOutSpeed = -8.0,
                Duration = -1,
                Flag = 1,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            },
            AttachEntity = {
                Bone = 9816,
                xPos = 0.0,
                yPos = 0.53,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0,
                P9 = false,
                UseSoftPinning = false,
                Collision = false,
                IsPed = false,
                VertexIndex = 2,
                FixedRot = false
            }
        }
    },
    [14] = {
        Name = "คุกเข่าจุ้บมือ",
        Source = {
            TaskAnim = {
                Dict = "penguin@mppos@custom@v8",
                Anim = "penguin_mppos_p13_duo4",
                BlendInSpeed = 8.0,
                BlendOutSpeed = 8.0,
                Duration = -1,
                Flag = 1,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            }
        },
        Target = {
            TaskAnim = {
                Dict = "penguin@mppos@custom@v8",
                Anim = "penguin_mppos_p14_duo4",
                BlendInSpeed = 8.0,
                BlendOutSpeed = -8.0,
                Duration = -1,
                Flag = 1,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            },
            AttachEntity = {
                Bone = 9816,
                xPos = -0.78,
                yPos = 0.0,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0,
                P9 = false,
                UseSoftPinning = false,
                Collision = false,
                IsPed = false,
                VertexIndex = 2,
                FixedRot = false
            }
        }
    },
    [15] = {
        Name = "อุ้มเกาะเอว (เดินได้)",
        Source = {
            TaskAnim = {
                Dict = "penguin@carry@1",
                Anim = "penguin_carry_2",
                BlendInSpeed = 8.0,
                BlendOutSpeed = 8.0,
                Duration = -1,
                Flag = 50,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            }
        },
        Target = {
            TaskAnim = {
                Dict = "penguin@carry@1",
                Anim = "penguin_carry_1",
                BlendInSpeed = 8.0,
                BlendOutSpeed = -8.0,
                Duration = -1,
                Flag = 1,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            },
            AttachEntity = {
                Bone = 9816,
                xPos = 0.0,
                yPos = 0.0,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0,
                P9 = false,
                UseSoftPinning = false,
                Collision = false,
                IsPed = false,
                VertexIndex = 2,
                FixedRot = false
            }
        }
    },
    [16] = {
        Name = "อุ้มเกาะเอว (เดินไม่ได้)",
        Source = {
            TaskAnim = {
                Dict = "penguin@carry@1",
                Anim = "penguin_carry_2",
                BlendInSpeed = 8.0,
                BlendOutSpeed = 8.0,
                Duration = -1,
                Flag = 1,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            }
        },
        Target = {
            TaskAnim = {
                Dict = "penguin@carry@1",
                Anim = "penguin_carry_1",
                BlendInSpeed = 8.0,
                BlendOutSpeed = -8.0,
                Duration = -1,
                Flag = 1,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            },
            AttachEntity = {
                Bone = 9816,
                xPos = 0.0,
                yPos = 0.0,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0,
                P9 = false,
                UseSoftPinning = false,
                Collision = false,
                IsPed = false,
                VertexIndex = 2,
                FixedRot = false
            }
        }
    },
    [17] = {
        Name = "ดัดหลัง",
        Source = {
            TaskAnim = {
                Dict = "penguin@mppos@custom@v9",
                Anim = "penguin_mppos_8_v9",
                BlendInSpeed = 8.0,
                BlendOutSpeed = 8.0,
                Duration = -1,
                Flag = 1,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            }
        },
        Target = {
            TaskAnim = {
                Dict = "penguin@mppos@custom@v9",
                Anim = "penguin_mppos_9_v9",
                BlendInSpeed = 8.0,
                BlendOutSpeed = -8.0,
                Duration = -1,
                Flag = 33,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            },
            AttachEntity = {
                Bone = 9816,
                xPos = 0.0,
                yPos = 0.0,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0,
                P9 = false,
                UseSoftPinning = false,
                Collision = false,
                IsPed = false,
                VertexIndex = 2,
                FixedRot = false
            }
        }
    },
    [18] = {
        Name = "ควงแขน",
        Source = {
            TaskAnim = {
                Dict = "penguin@mppos@custom@v9",
                Anim = "penguin_mppos_10_v9",
                BlendInSpeed = 8.0,
                BlendOutSpeed = 8.0,
                Duration = -1,
                Flag = 1,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            }
        },
        Target = {
            TaskAnim = {
                Dict = "penguin@mppos@custom@v9",
                Anim = "penguin_mppos_11_v9",
                BlendInSpeed = 8.0,
                BlendOutSpeed = -8.0,
                Duration = -1,
                Flag = 33,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            },
            AttachEntity = {
                Bone = 9816,
                xPos = 0.0,
                yPos = 0.0,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0,
                P9 = false,
                UseSoftPinning = false,
                Collision = false,
                IsPed = false,
                VertexIndex = 2,
                FixedRot = false
            }
        }
    },
    [19] = {
        Name = "วิดพื้น (นั่งบนหลัง)",
        Source = {
            TaskAnim = {
                Dict = "penguin@mppos@custom@v9",
                Anim = "penguin_mppos_13_v9",
                BlendInSpeed = 8.0,
                BlendOutSpeed = 8.0,
                Duration = -1,
                Flag = 1,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            }
        },
        Target = {
            TaskAnim = {
                Dict = "penguin@mppos@custom@v9",
                Anim = "penguin_mppos_14_v9",
                BlendInSpeed = 8.0,
                BlendOutSpeed = -8.0,
                Duration = -1,
                Flag = 33,
                PlaybackRate = 0,
                X = false,
                Y = false,
                Z = false
            },
            AttachEntity = {
                Bone = 9816,
                xPos = 0.0,
                yPos = 0.0,
                zPos = 0.0,
                xRot = 0.0,
                yRot = 0.0,
                zRot = 0.0,
                P9 = false,
                UseSoftPinning = false,
                Collision = false,
                IsPed = false,
                VertexIndex = 2,
                FixedRot = false
            }
        }
    },
}
