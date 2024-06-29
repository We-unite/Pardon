#!/usr/bin/env python
import matplotlib.pyplot as plt
from matplotlib.widgets import Button, TextBox
from tkinter.filedialog import askopenfilename
from scipy.ndimage import binary_dilation
import numpy as np
import os

def load_and_process_image(file_path, structure_size):
    with open(file_path, 'r') as f:
        f.readline()  # 忽略第一行
        lines = f.readlines()
        lines = lines[::-1]  # 颠倒一下，第一行在最下面

    image_data = [list(map(int, line.strip().split())) for line in lines]
    image_array = np.array(image_data)
    structure = np.ones((structure_size, structure_size))
    image_array = binary_dilation(image_array, structure)
    return image_array

def on_button_click(event):
    global file_path
    file_path = askopenfilename()
    structure_size = int(text_box.text)
    image_array = load_and_process_image(file_path, structure_size)
    ax.cla()
    ax.imshow(image_array, cmap='gray', interpolation='nearest')
    ax.set_title(file_path)
    fig.canvas.draw()

def update_cursor_position(event):
    if event.inaxes == ax:
        x, y = event.xdata, event.ydata
        x -= 900
        y -= 900
        ax.set_title(f'{file_path} | Cursor: ({x:.2f}, {-y:.2f})')
        fig.canvas.draw_idle()

if __name__ == '__main__':
    fig, ax = plt.subplots()
    ax_button = plt.axes([0.05, 0.85, 0.1, 0.075])
    button = Button(ax_button, 'Open')
    file_path = os.getcwd()
    button.on_clicked(on_button_click)
    
    ax_text_box = plt.axes([0.05, 0.95, 0.1, 0.05])
    text_box = TextBox(ax_text_box, 'Size')
    text_box.set_val(1)
    
    fig.canvas.mpl_connect('motion_notify_event', update_cursor_position)
    
    plt.show()