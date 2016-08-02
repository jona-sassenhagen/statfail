import pyqrcode
import os.path
url = pyqrcode.create('https://arxiv.org/abs/1602.04565')
url.eps(os.path.join('figures','arxiv-url.eps'), scale=2) 
url = pyqrcode.create('https://palday.shinyapps.io/statfail/')
url.eps(os.path.join('figures','shinyapps-url.eps'), scale=2) 