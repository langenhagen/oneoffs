#!/usr/bin/env python3
"""Give randomized Prompts to render Diorama images.

author: andreasl
"""

import subprocess
from itertools import product
from random import shuffle

occasions = [
    "january",
    "february",
    "march",
    "april",
    "may",
    "june",
    "july",
    "august",
    "september",
    "october",
    "november",
    "december",
    "spring",
    "summer",
    "autumn",
    "winter",
    "easter",
    "midsummer",
    "summer vacation",
    "thanksgiving",
    "halloween",
    "christmas",
    "silvester",
    "new year's eve",
    "hanukkah",
    "boxing day",
    "valentine's day",
    "diwali",
    "purim",
    "st. patrick's day",
    "yom kippur",
    "carnival",
    "midsummer's dream",
]
daytimes = ["morning", "day", "evening", "night"]
vibes = [
    "with cozy lighting",
    "with lights from below",
    "with a cozy feeling",
    "with warm lighting",
    "with candlelight",
    "with fairy lights",
    "with soft ambient glow",
    "with fireplace glow",
    "with lanterns",
]

cameras = ["analog", "DSLR"]

perms = list(product(occasions, daytimes, vibes, cameras))
shuffle(perms)

# i = 0
# while i < len(perms):
#     o, d, v, c = perms[i]
#     print(f"OCCASION: {o}; DAYTIME: {d}; VIBE: {v} CAMERA: {c}")
#     i += 1


occasion, daytime, vibe, camera = perms[0]

prompt = f"""Create an image of a {camera} photograph of a {occasion} {daytime} diorama with {vibe} at 3840 x 2160 pixels, landscape format. In the image there should be no text, no date or year or alike, no soldier or military scene. It should be a Diorama with 3d objects, i.e. a {camera} photograph of a diorama. The occasion ({occasion}) should be evident from the photograph.

The image should look like a {camera} PHOTOGRAPH of a DIORAMA.

So overall all this is important, but most important, this is a PHOTOGRAPH of a DIORAMA.
"""

print(prompt)


def copy_to_clipboard(text):
    subprocess.run(["xclip", "-selection", "clipboard"], input=text.encode())


copy_to_clipboard(prompt)
