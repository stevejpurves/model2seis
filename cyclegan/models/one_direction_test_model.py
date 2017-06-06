from torch.autograd import Variable
from collections import OrderedDict
import util.util as util
from .base_model import BaseModel
from . import networks


class OneDirectionTestModel(BaseModel):
    def name(self):
        return 'OneDirectionTestModel'

    def initialize(self, opt):
        BaseModel.initialize(self, opt)

        nb = opt.batchSize
        size = opt.fineSize
        self.input_A = self.Tensor(nb, opt.input_nc, size, size)

        assert(not self.isTrain)
        self.netG_A = networks.define_G(opt.input_nc, opt.output_nc,
                                        opt.ngf, opt.which_model_netG,
                                        opt.norm, opt.use_dropout,
                                        self.gpu_ids)
        which_epoch = opt.which_epoch
        #AtoB = self.opt.which_direction == 'AtoB'
        #which_network = 'G_A' if AtoB else 'G_B'
        self.load_network(self.netG_A, 'G', which_epoch)

        print('---------- Networks initialized -------------')
        networks.print_network(self.netG_A)
        print('-----------------------------------------------')

    def set_input(self, input):
        AtoB = self.opt.which_direction == 'AtoB'
        input_A = input['A' if AtoB else 'B']
        self.input_A.resize_(input_A.size()).copy_(input_A)
        self.image_paths = input['A_paths' if AtoB else 'B_paths']

    def test(self):
        self.real_A = Variable(self.input_A)
        self.fake_B = self.netG_A.forward(self.real_A)

    #get image paths
    def get_image_paths(self):
        return self.image_paths

    def get_current_visuals(self):
        real_A = util.tensor2im(self.real_A.data)
        fake_B = util.tensor2im(self.fake_B.data)
        return OrderedDict([('real_A', real_A), ('fake_B', fake_B)])

