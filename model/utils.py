import matplotlib.pyplot as plt
import numpy as np
from mpl_toolkits.axes_grid1 import make_axes_locatable

def saveAsPng(fig, ax, slice, filename):
    divider = make_axes_locatable(ax)
    cax = divider.append_axes('right', size='5%', pad=0.05)
    im = ax.imshow(slice)
    fig.colorbar(im, cax=cax, orientation='vertical')
    plt.savefig(filename+'.png')

def extractSlicesFromBlock(model, steps, filename_stub):
    fig, ax = plt.subplots()
    # save out x-z sections
    for n in range(0, model.shape[1], steps[0]):
        slice = np.transpose(np.squeeze(model[:,n,:]))
        filename = filename_stub+'xz'+str(n)
        saveAsPng(fig, ax,slice, filename)
        with open(filename+'.su', 'wb+') as f:
            f.write(slice.byteswap().tobytes())
    # save out y-z sections
    for n in range(0, model.shape[2], steps[1]):
        slice = np.transpose(np.squeeze(model[:,:,n]))
        filename=filename_stub+'yz'+str(n);
        saveAsPng(fig, ax,slice, filename)
        with open(filename+'.su', 'wb+') as f:
            f.write(slice.byteswap().tobytes())
            
def loadBlock(model_name, block_shape, cube_size):
    model = np.genfromtxt(model_name+".g01", dtype='float')
    block_size = map(lambda x: x/cube_size, block_shape) # must match that in history file
    model = model.reshape(block_size)
    return model